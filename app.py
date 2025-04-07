from flask import Flask, request, jsonify, make_response, g
import psycopg2
from functools import wraps
import hashlib
import re
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives import hashes, serialization
import base64
import jwt
import datetime

allowed_semesters = {
    'FALL': 2025,
    'SUMMER': 2025
}

allowed_credits = 9

# Step 1: Load the Private Key from a .pem file
def load_private_key(private_key_path):
    with open(private_key_path, "rb") as key_file:
        private_key = serialization.load_pem_private_key(
            key_file.read(),
            password=None  # Use password here if the private key is encrypted
        )
    return private_key

# Step 2: Decrypt the encrypted text using the private key
def decrypt_text(encrypted_text, private_key):
    encrypted_bytes = base64.b64decode(encrypted_text)
    decrypted = private_key.decrypt(
        encrypted_bytes,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    return decrypted.decode('utf-8')

# Step 4: JWT Secret Key
JWT_SECRET = "my_jwt_secret_key"  # Change this to a strong, random secret in production

private_key = load_private_key("private_key.pem")

app = Flask(__name__)

# Database connection settings
DB_CONFIG = {
    "dbname": "university",
    "user": "postgres",
    "password": "Divyasql25",
    "host": "localhost",
    "port": "5432"
}

def auth_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = request.cookies.get('token')
        if not token:
            return jsonify({"error": "Missing token"}), 401
        try:
            payload = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
            # Attach user_id to the global request context
            g.user_id = payload["user_id"]
        except jwt.ExpiredSignatureError:
            return jsonify({"error": "Token expired"}), 401
        except jwt.InvalidTokenError:
            return jsonify({"error": "Invalid token"}), 401
        return f(*args, **kwargs)
    return decorated_function

def get_db_connection():
    return psycopg2.connect(**DB_CONFIG)

@app.route('/api/v1/login', methods=['POST'])
def login():
    data = request.get_json()

    # Validate input fields
    email = data.get("email")
    encrypted_password = data.get("password")

    if not email or not encrypted_password:
        return jsonify({"error": "Missing email or password"}), 400

    try:
        # Decrypt the password
        password = decrypt_text(encrypted_password, private_key)
        hashed_password = hash_password(password)

        conn = get_db_connection()
        cur = conn.cursor()

        # Check if the user exists with the given email and password
        query = """
            SELECT id, name, email_id, personal_email_id
            FROM Students
            WHERE (email_id = %s OR personal_email_id = %s) AND password = %s
        """
        cur.execute(query, (email, email, hashed_password))
        user = cur.fetchone()

        if not user:
            return jsonify({"error": "Invalid email or password"}), 401

        # Create JWT token
        payload = {
            "user_id": user[0],
            "email": user[2] if email == user[2] else user[3],
            "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=1)  # Token expiration time
        }

        token = jwt.encode(payload, JWT_SECRET, algorithm="HS256")

        # Set JWT token in HTTP-only cookie
        response = make_response(jsonify({"message": "Login successful", "user_id": user[0]}))
        response.set_cookie("token", token, httponly=True, secure=True, max_age=3600)  # 1 hour expiry

        cur.close()
        conn.close()

        return response

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/v1/protected', methods=['GET'])
def protected():
    token = request.cookies.get('token')

    if not token:
        return jsonify({"error": "Missing token"}), 401

    try:
        payload = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
        return jsonify({"message": "Protected content accessed", "user": payload})

    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401

@app.route('/api/v1/courses/offered', methods=['GET'])
def get_courses_offered():
    semester = request.args.get('semester', '').upper()
    year = request.args.get('year', type=int)
    search = request.args.get('search', '')

    if not semester or not year:
        return jsonify({"error": "Missing required parameters"}), 400

    query = """
        SELECT c.name, c.course_code, co.id as course_offered_id
        FROM courses_offered co
        INNER JOIN courses c ON co.course_id = c.id
        WHERE co.semester = %s AND co.year = %s AND c.course_code ILIKE %s;
    """
    search_param = f"%{search}%"

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(query, (semester, year, search_param))
        courses = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]
        cur.close()
        conn.close()

        result = [dict(zip(column_names, course)) for course in courses]
        return jsonify(result)

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/v1/colleges', methods=['GET'])
def get_college():

    query = """
        SELECT id, name from college
    """


    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(query)
        colleges = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]
        cur.close()
        conn.close()

        result = [dict(zip(column_names, college)) for college in colleges]
        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/v1/department', methods=['GET'])
def get_department():

    query = """
        SELECT id, name, college_id from department 
    """


    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(query)
        departments = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]
        cur.close()
        conn.close()

        print(f"this is column names {column_names}")

        result = [dict(zip(column_names, department)) for department in departments]
        return jsonify(result)

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/v1/program', methods=['GET'])
def get_program():

    query = """
        SELECT id, name, level from programs 
    """

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(query)
        programs = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]
        cur.close()
        conn.close()

        print(f"this is column names {column_names}")

        result = [dict(zip(column_names, program)) for program in programs]
        return jsonify(result)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/v1/courses_offered/<int:course_offered_id>', methods=['GET'])
def get_course_offered(course_offered_id):
    return jsonify(get_course_offered_details(course_offered_id))


def get_pre_requisite_results(student_id, pre_requisites):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Format the pre_requisites list for the IN clause
    formatted_pre_requisites = ', '.join(['%s'] * len(pre_requisites))

    # Query with IN clause for pre_requisites
    query = f"""SELECT sg.result, c.course_code
                FROM student_grades sg
                INNER JOIN course_registration cr ON sg.course_registration_id = cr.id
                INNER JOIN courses_offered co ON cr.course_offered_id = co.id
                INNER JOIN courses c ON co.course_id = c.id
                WHERE c.pre_requisite IN ({formatted_pre_requisites}) AND cr.student_id = %s;"""

    # Execute query
    cursor.execute(query, pre_requisites + [student_id])

    # Fetch results and convert to list of dictionaries
    pre_requisite_results = cursor.fetchall()
    column_names = [desc[0] for desc in cursor.description]
    cursor.close()
    conn.close()

    result = [dict(zip(column_names, pre_requisite_result)) for pre_requisite_result in pre_requisite_results]
    return result


def get_course_offered_details(course_offered_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    query = """
        SELECT co.id, co.lectured_by, co.course_id, co.semester, co.year, 
               co.start_time, co.end_time, co.day_of_week, 
               c.name, c.course_code, c.credits, c.total_hours, 
               s.name AS lecturer_name, cr.room_number,
               COALESCE(
                   json_agg(
                       CASE WHEN prereq.id IS NOT NULL THEN
                           json_build_object(
                               'id', prereq.id, 'name', prereq.name, 'course_code', prereq.course_code)
                       END
                   ) FILTER (WHERE prereq.id IS NOT NULL), '[]'
               ) AS prerequisite_courses
        FROM courses_offered co
        INNER JOIN courses c ON co.course_id = c.id
        INNER JOIN staff s ON co.lectured_by = s.id
        INNER JOIN classrooms cr ON co.class_room_id = cr.id
        LEFT JOIN courses prereq ON prereq.id = c.pre_requisite 
        WHERE co.id = %s
        GROUP BY co.id, co.lectured_by, co.course_id, co.semester, co.year, 
                 co.start_time, co.end_time, co.day_of_week, 
                 c.name, c.course_code, c.credits, c.total_hours, 
                 s.name, cr.room_number;
    """
    cursor.execute(query, (course_offered_id,))
    course_details = cursor.fetchone()
    if not course_details:
        return jsonify({"error": "Course offered ID not found"}), 404
    # Column mapping
    columns = ["id", "lectured_by", "course_id", "semester", "year", "start_time", "end_time", "day_of_week",
               "course_name", "course_code", "credits", "total_hours", "lecturer_name", "room_number",
               "prerequisite_courses"]
    course_data = dict(zip(columns, course_details))
    # Convert time fields to string format
    if isinstance(course_data["start_time"], (tuple, list)):
        course_data["start_time"] = str(course_data["start_time"])
    if isinstance(course_data["end_time"], (tuple, list)):
        course_data["end_time"] = str(course_data["end_time"])
    course_data["start_time"] = str(course_data["start_time"])
    course_data["end_time"] = str(course_data["end_time"])
    cursor.close()
    conn.close()
    return course_data


def get_registered_courses(student_id, semester, year):
    conn = get_db_connection()
    cursor = conn.cursor()
    query = """select cr.course_offered_id, co.semester, co.year, c.credits from course_registration cr
inner join courses_offered co on cr.course_offered_id=co.id
inner join courses c on cr.course_offered_id=c.id where cr.student_id = %s and semester=%s and year = %s"""
    cursor.execute(query, (student_id, semester, year))
    registered_courses = cursor.fetchall()
    column_names = [desc[0] for desc in cursor.description]
    cursor.close()
    conn.close()
    result = [dict(zip(column_names, registered_course)) for registered_course in registered_courses]
    return result


@app.route('/api/v1/register/courses', methods=['GET'])
@auth_required
def fetch_registered_courses():
    semester = request.args.get('semester', '').upper()
    year = request.args.get('year', type=int)
    registered_courses = get_registered_courses(str(g.user_id), semester, year)
    return jsonify(registered_courses), 200


@app.route('/api/v1/register/course/<int:course_offered_id>', methods=['POST'])
@auth_required
def register_new_course(course_offered_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    course_offered_details = get_course_offered_details(course_offered_id)
    if course_offered_details is None:
        return jsonify({"status": "course not found"}), 404

    registered_courses = get_registered_courses(str(g.user_id), course_offered_details["semester"], str(course_offered_details["year"]))

    sum_credits = 0
    for registered_course in registered_courses:
        if registered_course["course_offered_id"] == course_offered_id:
            return jsonify({"status": "you have already registered for this course"}), 409
        sum_credits = sum_credits + int(registered_course["credits"])

    if sum_credits >= allowed_credits:
        return jsonify({"status": "max credits reached"}), 500

    if (allowed_credits - sum_credits) < course_offered_details["credits"]:
        return jsonify({"status": "remaining credits not sufficient for this course"}), 500

    pre_requisites = []
    for course in course_offered_details["prerequisite_courses"]:
        pre_requisites.append(course["id"])

    if len(pre_requisites) > 0:
        pre_requisites_results = get_pre_requisite_results(g.user_id, pre_requisites)

        if len(pre_requisites) != len(pre_requisites_results):
            return jsonify({"status": "missing pre requisite"}), 400

        for result in pre_requisites_results:
            if result["result"] != "PASS":
                return jsonify({"status": "missing pre requisite"}), 400

    query="""insert into course_registration(student_id, course_offered_id) values (%s, %s);"""
    cursor.execute(query, (g.user_id, course_offered_id,))
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"status": "course registered"}), 200


# Function to hash passwords securely
def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

# Validate email format
def is_valid_email(email):
    return re.match(r"[^@]+@[^@]+\.[^@]+", email)

def is_valid_password(password):
    pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
    return re.match(pattern, password)

@app.route('/api/v1/students', methods=['POST'])
def register_student():
    data = request.get_json()

    # Required fields
    required_fields = ["name", "gender", "email_id", "password", "joining_term", "joining_year", "nationality", "addresses", "program_id"]
    for field in required_fields:
        if field not in data or not data[field]:
            return jsonify({"error": f"Missing required field: {field}"}), 400

    required_address_fields = ["street", "city", "state", "country", "zip"]
    for field in required_address_fields:
        for address in data["addresses"]:
            if field not in address or not address[field]:
                return jsonify({"error": f"Missing required address field: {field}"}), 400

    if not(len(data["addresses"]) == 1 or len(data["addresses"]) == 2):
        return jsonify({"error": "min one or maximum 2 addresses can be provided"}), 400

    if len(data["addresses"]) == 1:
        if not (data["addresses"][0]["is_permanent"] and data["addresses"][0]["is_current"]):
            return jsonify({"error": "permanent and current should be provided"}), 400
    else:
        is_permanent = False
        is_current = False
        for add in data["addresses"]:
            if add["is_permanent"]:
                if is_permanent:
                    return jsonify({"error": "Only one permanent address is allowed"}), 400
                is_permanent = True
            if add["is_current"]:
                if is_current:
                    return jsonify({"error": "Only one current address is allowed"}), 400
                is_current = True

        if not(is_permanent and is_current):
            return jsonify({"error": f"need both current and permanent address"}), 400


    # Extract and validate data
    name = data["name"].strip()
    gender = data["gender"].strip().capitalize()
    email_id = data["email_id"].strip().lower()
    personal_email = data.get("personal_email", "").strip().lower()
    encrypted_password = data["password"]
    joining_term = data["joining_term"].strip().upper()
    joining_year = data["joining_year"]
    phone_number = data.get("phone_number", "").strip()
    nationality = data["nationality"].strip().capitalize()

    password = decrypt_text(encrypted_password, private_key)


    # Email validation
    if not is_valid_email(email_id) or (personal_email and not is_valid_email(personal_email)):
        return jsonify({"error": "Invalid email format"}), 400

    # Validate password
    if not is_valid_password(password):
        return jsonify({
            "error": "Password must have at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long."
        }), 400

    # Validate joining year
    if not isinstance(joining_year, int) or joining_year < 2000 or joining_year > 2100:
        return jsonify({"error": "Invalid joining year"}), 400

    # Hash password
    hashed_password = hash_password(password)

    try:
        conn = get_db_connection()
        cur = conn.cursor()

        # Check if student already exists with email_id or personal_email_id
        cur.execute("SELECT id FROM Students WHERE email_id = %s OR personal_email_id = %s", (email_id, personal_email))
        existing_student = cur.fetchone()

        if existing_student:
            return jsonify({"error": "Student already exists with this email or personal email"}), 409

        # Insert student into database
        cur.execute("""
            INSERT INTO Students (name, gender, email_id, personal_email_id, password, joining_term, joining_year, phone_number, nationality)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING id
        """, (name, gender, email_id, personal_email, hashed_password, joining_term, joining_year, phone_number, nationality))

        student_id = cur.fetchone()[0]

        for address in data["addresses"]:
            cur.execute("""
            INSERT INTO student_address (student_id, street, aptno, city, state, country, is_permanent, is_current, zip) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (student_id, address["street"], address["aptno"], address["city"], address["state"] , address["country"], address["is_permanent"] , address["is_current"] , address["zip"]))

        cur.execute("""INSERT INTO program_registration(student_id, program_id) VALUES (%s,%s)""", (student_id, data["program_id"]))


        conn.commit()
        cur.close()
        conn.close()

        return jsonify({"message": "Student registered successfully", "student_id": student_id}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

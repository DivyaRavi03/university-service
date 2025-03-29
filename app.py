from flask import Flask, request, jsonify, make_response
import psycopg2
import hashlib
import re
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives import hashes, serialization
import base64
import jwt
import datetime

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

from flask import Flask, request, jsonify
import psycopg2

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

@app.route('/api/v1/courses/offered', methods=['GET'])
def get_courses_offered():
    semester = request.args.get('semester', '').upper()
    year = request.args.get('year', type=int)
    search = request.args.get('search', '')

    if not semester or not year:
        return jsonify({"error": "Missing required parameters"}), 400

    query = """
        SELECT c.*
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

if __name__ == '__main__':
    app.run(debug=True)

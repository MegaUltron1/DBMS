--University Schema

-CREATE TABLE degree_program (
  code VARCHAR(10) PRIMARY KEY  
) ENGINE=InnoDB;

CREATE TABLE class_level (
  code VARCHAR(15) PRIMARY KEY  
) ENGINE=InnoDB;

CREATE TABLE semester (
  code VARCHAR(10) PRIMARY KEY  
) ENGINE=InnoDB;

CREATE TABLE department (
  dept_code VARCHAR(10) PRIMARY KEY,
  dept_name VARCHAR(100) NOT NULL UNIQUE,
  office_number VARCHAR(20),
  office_phone VARCHAR(20),
  college VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE student (
  student_number BIGINT PRIMARY KEY,
  ssn VARCHAR(15) NOT NULL UNIQUE,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birth_date DATE,
  sex CHAR(1),  
  class VARCHAR(15),  
  degree_program VARCHAR(10),  
  current_address VARCHAR(200),
  current_phone VARCHAR(20),

  permanent_address VARCHAR(200),
  permanent_phone VARCHAR(20),
  perm_city VARCHAR(60),
  perm_state VARCHAR(60),
  perm_zip VARCHAR(15),

  major_dept_code VARCHAR(10) NOT NULL,
  minor_dept_code VARCHAR(10) NULL,

  CONSTRAINT fk_student_major_dept
    FOREIGN KEY (major_dept_code) REFERENCES department(dept_code)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_student_minor_dept
    FOREIGN KEY (minor_dept_code) REFERENCES department(dept_code)
      ON UPDATE CASCADE ON DELETE SET NULL
 
) ENGINE=InnoDB;

CREATE INDEX idx_student_last_name ON student(last_name);
CREATE INDEX idx_student_perm_city_state_zip ON student(perm_city, perm_state, perm_zip);

CREATE TABLE course (
  course_number VARCHAR(20) PRIMARY KEY,
  course_name VARCHAR(150) NOT NULL,
  description TEXT,
  semester_hours TINYINT UNSIGNED,
  level VARCHAR(20),  
  offering_dept_code VARCHAR(10) NOT NULL,
  CONSTRAINT fk_course_offering_dept
    FOREIGN KEY (offering_dept_code) REFERENCES department(dept_code)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE instructor (
  instructor_id BIGINT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(120) UNIQUE,
  office VARCHAR(50),
  dept_code VARCHAR(10),
  CONSTRAINT fk_instructor_dept
    FOREIGN KEY (dept_code) REFERENCES department(dept_code)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE section (
  course_number VARCHAR(20) NOT NULL,
  semester VARCHAR(10) NOT NULL,  
  year SMALLINT NOT NULL,
  section_number SMALLINT NOT NULL,  
    
  instructor VARCHAR(100),           
  instructor_id BIGINT NULL,        

  PRIMARY KEY (course_number, semester, year, section_number),

  CONSTRAINT fk_section_course
    FOREIGN KEY (course_number) REFERENCES course(course_number)
      ON UPDATE CASCADE ON DELETE RESTRICT,

  CONSTRAINT fk_section_instructor
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
      ON UPDATE CASCADE ON DELETE SET NULL


) ENGINE=InnoDB;

CREATE TABLE grade_report (
  student_number BIGINT NOT NULL,
  course_number VARCHAR(20) NOT NULL,
  semester VARCHAR(10) NOT NULL,
  year SMALLINT NOT NULL,
  section_number SMALLINT NOT NULL,

  letter_grade VARCHAR(2),   
  numeric_grade TINYINT,    

  PRIMARY KEY (student_number, course_number, semester, year, section_number),

  CONSTRAINT fk_gr_student
    FOREIGN KEY (student_number) REFERENCES student(student_number)
      ON UPDATE CASCADE ON DELETE CASCADE,

  CONSTRAINT fk_gr_section
    FOREIGN KEY (course_number, semester, year, section_number)
      REFERENCES section(course_number, semester, year, section_number)
      ON UPDATE CASCADE ON DELETE RESTRICT,

  CONSTRAINT chk_numeric_grade CHECK (numeric_grade IN (0,1,2,3,4))
) ENGINE=InnoDB;

CREATE INDEX idx_grade_report_by_section ON grade_report(course_number, semester, year, section_number);

CES student(student_number)
or_dept_code from student and rely on the bridge.


-- End of unified schema



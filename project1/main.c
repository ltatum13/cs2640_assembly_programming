#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define OUT_OF 100
#define MAX_LINE_LENGTH 256
#define NUM_STUDENTS 4

// struct to save student names, scores, letter grades,
// and output whether or not their code compiles
typedef struct {
        char name[20];
        int score;
        char grade[3];
	bool compiled;
} StudentGrade;

// function prototypes
void submissionsProcessor(StudentGrade students[], int num_students);
void getLetterGrade(StudentGrade *student);
int getScore(const char *filename);
void printGrades(StudentGrade *student, int num_students);

// creates struct array, holding all the
// students' information (student names, scores,
// letter grades, and if the student's code
// compiles)
void submissionsProcessor(StudentGrade students[], int num_students) {
  for (int i = 0; i < num_students; i++) {
    char filename[30];
    char student_num[5];
    char command[256];
  
    // create and assign students' names
    strcpy(students[i].name, "student");
    sprintf(student_num, "%d", i + 1);
    strcat(students[i].name, student_num);
    
    // create and assign students' submission
    // filenames
    strcpy(filename, students[i].name);
    strcat(filename, "-hw1.c");
    
    // get students' scores based on submission
    // and answer file comparison
    students[i].score = getScore(filename);

    // if the students' scores don't compile,
    // return as false and set score to 0, otherwise return true
    sprintf(command, "gcc -o temp_a.out %s 2>/dev/null", filename);
    int isCompilable = system(command);

    if (isCompilable != 0) {
      students[i].compiled = false;
      students[i].score = 0;
    } else students[i].compiled = true;
    
    // get students' letter grades
    getLetterGrade(&students[i]);
  }
}

// returns the student's scores after comparing
// student's source code to answer file line by line
int getScore(const char *filename) {
  char answer[MAX_LINE_LENGTH];
  char submission[MAX_LINE_LENGTH];
  int student_score = OUT_OF;
  char buffer[MAX_LINE_LENGTH];

  // file pointer for answer.c
  FILE *answer_file;
  answer_file = fopen("answer_code.c", "r");
  if (answer_file == NULL) {
    printf("Error opening file");
    exit(EXIT_FAILURE);
  }

  // file pointer for student source code file
  FILE *student_file;
  student_file = fopen(filename, "r");
  if (student_file == NULL) {
    printf("Error opening file");
    exit(EXIT_FAILURE);
  }

  // compare the student answers against the answer_code.c
  // subtract one point if a line from the submisson if different from
  // the answer code
  while ((fgets(answer, MAX_LINE_LENGTH, answer_file) != NULL) &&
	  (fgets(submission, MAX_LINE_LENGTH, student_file) != NULL)) {
    
    if (strcmp(answer, submission) != 0) student_score--;
  }

  return student_score;
 
  // close file pointers
  fclose(student_file);
  fclose(answer_file);
}

// returns the student's letter grade based on
// class syllabus
void getLetterGrade(StudentGrade *student) {
  // if the student's code doesn't compile,
  // set the student's grade to an F
  if (student->compiled == false) strcpy(student->grade, "F");

  int score = student->score;

  // if the code compiles, set the student's grade
  // based on the score they received
  if (score >= 94) {
    strcpy(student->grade, "A");
  } else if ((score >= 89) && (score <= 93.9)) {
    strcpy(student->grade, "A-");
  } else if ((score >= 86) && (score <= 88.9)) {
    strcpy(student->grade, "B+");
  } else if ((score >= 82) && (score <= 85.9)) {
    strcpy(student->grade, "B");
  } else if ((score >= 78) && (score <= 81.9)) {
    strcpy(student->grade, "B-");
  } else if ((score >= 75) && (score <= 77.9)) {
    strcpy(student->grade, "C+");
  } else if ((score >= 71) && (score <= 74.9)) {
    strcpy(student->grade, "C");
  } else if ((score >= 68) && (score <= 70.9)) {
    strcpy(student->grade, "C-");
  } else if ((score >= 65) && (score <= 67.9)) {
    strcpy(student->grade, "D+");
  } else if ((score >= 61) && (score <= 64.9)) {
    strcpy(student->grade, "D");
  } else if ((score >= 58) && (score <= 60.9)) {
    strcpy(student->grade, "D-");
  } else strcpy(student->grade, "F");
}

// prints students' grades, sorted by grade
// ex.) Naomi 97 A
void printGrades(StudentGrade *student, int num_students) {
  // sort the students array in order of score
  for (int i = 0; i < num_students; i++) {
  int max_index = i;
    
  for (int j = i + 1; j < num_students; j++) {
    if (student[j].score > student[max_index].score)
      max_index = j;
    }

    StudentGrade temp = student[i];
    student[i] = student[max_index];
    student[max_index] = temp;
  }
  
  // print the sorted grades
  for (int k = 0; k < num_students; k++) {
    if (student[k].compiled == false) printf("%s DNC %s\n", student[k].name, student[k].grade);
    else printf("%s %d %s\n", student[k].name, student[k].score, student[k].grade);
  }
}

int main() {
  StudentGrade students[NUM_STUDENTS];
  submissionsProcessor(students, NUM_STUDENTS);
  printGrades(students, NUM_STUDENTS);
  
  return 0;
}

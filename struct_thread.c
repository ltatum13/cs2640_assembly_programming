#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

struct Student {
  int age;
  float gpa;
};

void *print_student(void *student) {
  struct Student s1 = (struct Student*) student;
  printf("Student age: %d \n", s1->age);
  printf("Student GPA: %f \n", s1->gpa);
}

int main() {
  pthread_t cris_thread, lucero_thread;
  struct Student cris, lucero;

  cris.age = 20;
  cris.gpa = 3.0;

  lucero.age = 19;
  lucero.gpa = 3.5;

  // Create independent threads
  pthread_create(&cris_thread, NULL, print_student, (void *) &cris);
  pthread_create(&lucero_thread, NULL, print_student, (void *) &lucero);

  // Wait for threads to all finish
  pthread_join(cris_thread, NULL);
  pthread_join(lucero_thread, NULL);

  return 0;
}

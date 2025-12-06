#include <stdio.h>
#include <stdlib.h>
#include <pthread.h> // must include -lpthread to compiler arguments

void *print_message_func(void *ptr) {
  char *message;
  message = (char *) ptr;
  printf("%s \n", message);
}

int main() {
  pthread_t thread1, thread2;
  char *message1 = "Thread 1 Message";
  char *message2 = "Thread 2 Message";
  int ret_val1, ret_val2;

  // create independent threads
  ret_val1 = pthread_create(&thread1, NULL, print_message_func, (void *) message1);
  ret_val2 = pthread_create(&thread2, NULL, print_message_func, (void *) message2);

  pthread_join(thread1, NULL); // wait until thread 1 finishes
  pthread_join(thread2, NULL); // wait until thread 2 finishes

  printf("Thread 1 returns: %d \n", ret_val1);
  printf("Thread 2 returns: %d \n", ret_val2);
}

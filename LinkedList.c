// Write a program that implements the add() and remove() methods to LinkedList
#include <stdio.h>
#include <stdlib.h>

struct Node {
  int data;
  struct Node *next;
};

struct Node *head;

void insert(int newData) {
  struct Node newNode;

  if (head == NULL) {
    head->data = newData;
  } else {
    next->data = newData;
  }
}

void print() {
  while (next != NULL) {
    printf("%d \n", next->data);
    next = next->data;
  }
}

void add(int data) {
  struct Node newNode;

  if (head == NULL) {
    head->data = data;
  } else {
    next->data = data;
  }
}

void remove() {
  struct Node newNode;

  if (head == NULL) {
    head->data = data;
  } else {
    next->data = data;
  }
}

int main() {
  insert(1);
  insert(2);
  insert(3);
  print();
  return 0;
}

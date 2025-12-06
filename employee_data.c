#include <stdio.h>
struct Employee {
	char name[10];
	int age;
	int salary;
};

int main() {
	struct Employee e1; 
	
	printf("Enter name: \n");
	scanf("%s", e1.name);

	printf("Enter age: \n");
	scanf("%d", &e1.age);

	printf("Enter salary: \n");
	scanf("%d", &e1.salary);

	fscanf(fp, "%s %d %d", e1.name, e1.age, e1.salary);

	return 0;
}

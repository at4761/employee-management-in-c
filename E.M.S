#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
int main()
{
    FILE *fp,*ft;
    char another,choice;

    struct employee
{
    char name[40];
    int age;
    float salary;
};
struct  employee a;

char employeename[40];
long int resize;
int y;

fp=fopen("EMP.DAT","rb+");

if(fp==NULL)
    {
    fp= fopen("EMP.DAT","wb+");
    if(fp==NULL)
    {
        printf("Cannot open file");
        exit(1);
    }
}
resize=sizeof(a);

while(1)
{
    system("cls");
    printf("1. Add Record\n");
     printf("2. List Records\n");
      printf("3. Modify Records\n");
       printf("4. Delete Record\n");
       printf("5. Exit\n");
         printf("Your Choice: ");
         fflush(stdin);
         choice = getche();

         switch(choice)
         {
     case '1':
        system("cls");
        fseek(fp,0,SEEK_END);

        another='y';
        while(another=='y'){
            printf("\nEnter Name: ");
            scanf("%s",&a.name);
            printf("\nEnter Age: ");
            scanf("%d",&a.age);
            printf("\nEnter Salary: ");
            scanf("%f",&a.salary);

            fwrite(&a,resize,1,fp);

            printf("\nAdd another record(y/n)\n");
            fflush(stdin);
            another=getche();
        }

        break;
     case '2':
        system("cls");
        rewind(fp);
        while(fread(&a,resize,1,fp)==1)
            {
            printf("\n%s  %d  %.2f",a.name,a.age,a.salary);
        }
        getch();
        break;

     case '3':
        system("cls");
        another='y';
        while(another == 'y')
            {
                printf("Enter the employee name to modify: ");
        scanf("%s",employeename);
        rewind(fp);
        while(fread(&a,resize,1,fp)==1)
            {
            if(strcmp(a.name,employeename)==0)
            {
                printf("\nEnter new name,age and salary: ");
                scanf("%s%d%f",&a.name,&a.age,&a.salary);
                fseek(fp,-resize,SEEK_CUR);
                fwrite(&a,resize,1,fp);
                break;
            }
        }
        printf("\nModify another record(y/n)\n");
        fflush(stdin);
        another=getche();
        }
        break;
     case '4':
        system("cls");
        another='y';
        while(another == 'y')
        {
            printf("\nEnter name of employee to delete: ");
            scanf("%s",employeename);
            ft=fopen("Temp.dat","wb");
            rewind(fp);
            while(fread(&a,resize,1,fp)==1)
            {
                if(strcmp(a.name,employeename)!=0)
                {
                    fwrite(&a,resize,1,ft);
                }
            }
            fclose(fp);
            fclose(ft);
            remove("EMP.DAT");
            rename("Temp.dat","EMP.DAT");
            fp=fopen("EMP.DAT","rb+");
            fflush(stdin);
            another=getche;
        }
        break;

     case '5':
        fclose(fp);
        exit(0);
}
}
    return 0;
}

# devops-netology
Учебный репозиторий devops-netology DEVOPS-27

#Файл .gitignore
Файл .gitignore используется git для того, чтобы игнорировать некоторые файлы и папки.
Так например я создал файл ./terraform/.gitignore и в файле указал какие папки и файлы игнорировать:
**/.terraform/* - все файлы из каталогов, содержащих имя .terraform; 
*.tfstate - все файлы, которые заканчиваются на *.tfstate;
*.tfstate.* - все файлы, содержащие имя tfstate;
crash.log - файл crash.log;
crash.*.log - файлы, начинающиеся на crash и оканчивающиеся на .log;
*.tfvars - все файлы, оканчивающиеся на .tfvars;
*.tfvars.json - все файлы, оканчивающиеся на .tfvars.json;
override.tf - файл override.tf;
override.tf.json - файл override.tf.json;
*_override.tf - все файлы, оканчивающиеся на *_override.tf;
*_override.tf.json - все файлы, оканчивающиеся на _override.tf.json;
.terraformrc - все файлы, которые заканчиваются на *.terraformrc;
terraform.rc - файл terraform.rc

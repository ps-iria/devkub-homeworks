# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"
Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте
Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods

## Ответ:
Запускал в minikube

![](12.2.1.png)

## Задание 2: Просмотр логов для разработки
Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)

## Ответ

Пользователь и роль созданы командами 
```
kubectl create serviceaccount viewer
kubectl create role viewer --verb=get --verb=list --verb=logs --verb=describe --resource=pods/log --resource=pods
kubectl create rolebinding viewer-binding --role=viewer --user=viewer

не нашел как правильно создать токен через create, но строкой kubectl create secret generic viewer-token --type=kubernetes.io/service-account-token:viewer не получилось
создал через apply:
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: viewer-token
  annotations:
    kubernetes.io/service-account.name: viewer
type: kubernetes.io/service-account-token
EOF

kubectl config set-credentials viewer --token eyJhbGciOiJSUzI1NiIsImtpZCI6IlAyNlU2S2NiZGNSX1RLcDMwckQySmlCY0JZWDhpV29MUG1fc1RldUQzeDAifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InZpZXdlci10b2tlbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJ2aWV3ZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJhMzA3ZjU1NC02NWE1LTRiNzgtYTE0MS0yZWVlNTAzNmQwODEiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDp2aWV3ZXIifQ.Td4jLzkLiSmPxNV6lsBbSRh8_0ncTmpM8YB7doKPQPngmttPFZ1IH45LbyNXyW-Idp6_o33uGHYufVqHMtDnyqnmmn3g4P2Ykfc23LR_CqW5PkRoI9PZ0qRLacsRvcQuDWjvvfZztHU0tcPKKKhkLQHpygMvol-YqdEgVsUp0yGplS2l8TcnBW5RYv1n2OTuFNE4NDrd4LVxTS3LyEUnxAEC23gAw5q3hBE2k-3MwBRFW-HWbaNnFEQhy8S8HtdvRQDcBdcHPJvr3ym6XcNLoEwIp8eApntja9ix8HjrzJfLCbdk2KAVHVMKLRzfXA9VouZ78-z-_myzvhgsyUxd-A
```
После переключения на viewer:
![](12.2.2.png)

## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

## Ответ

![](12.2.3.png)
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
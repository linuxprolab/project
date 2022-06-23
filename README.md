# Курсовой проект. Развертывание инфраструктуры для web-приложения CTFd.
В качестве web-приложения выбран CTFd. https://ctfd.io/
## Схема проекта
![net scheme](img/scheme.png)
## Статус выполнения 
- [x] включен http
- [x] основная инфраструктура в DMZ зоне
- [x] файрвалл на входе
- [x] сбор метрик и настроенный алертинг
  - [x] сбор метрик -> Prometheus
  - [ ] TODO настроенный алертинг
- [ ] везде включен selinux
- [x] организован централизованный сбор логов -> ELK
  - [x] nginx
  - [ ] TODO остальное
- [x] организован backup базы -> bash скрипты
## Запуск и проверка
- Клонируем репозиторий:

```
git clone https://github.com/linuxprolab/project
cd project
```
- В `Vagrantfile` необходимо внести изменения в настройки `public` интерфейса машины `bastion`:
```
MACHINES = {
  :'bastion' => {
    :host_name => 'bastion',
    :box_name => "centos/8",
    :public => {ip: '<YOUR IP ADDRESS>, adapter:3, bridge:'<YOUR INTERFACE>'},
    :net => [
      {ip: '192.168.0.1', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "internal-net"},           
    ],
    :ports => [
      {guest: 22, host: 22001, id: 'ssh'}, 
    ], 
  },
```
- Поднимаем виртуалки:
```
vagrant up
```
- Запускаем плейбуки ansible:
```
ansible-playbook playbooks/main.yml -i inventories/all.yml 
```
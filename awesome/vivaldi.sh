#!/bin/bash

# Открываем первый экземпляр Vivaldi
vivaldi-stable &

# Ждем, пока окно загрузится
sleep 5

# Получаем идентификатор окна
window_id=$(xdotool search --sync --onlyvisible --class "Vivaldi-stable")

# Устанавливаем WM_CLASS для первого экземпляра
xdotool set_window --class "Vivaldi-instance1" $window_id

# Открываем второй экземпляр Vivaldi
vivaldi-stable &

# Ждем, пока окно загрузится
sleep 5

# Получаем идентификатор второго окна
window_id=$(xdotool search --sync --onlyvisible --class "Vivaldi-stable")

# Устанавливаем WM_CLASS для второго экземпляра
xdotool set_window --class "Vivaldi-instance2" $window_id

# Открываем третий экземпляр Vivaldi
vivaldi-stable &

# Ждем, пока окно загрузится
sleep 5

# Получаем идентификатор третьего окна
window_id=$(xdotool search --sync --onlyvisible --class "Vivaldi-stable")

# Устанавливаем WM_CLASS для третьего экземпляра
xdotool set_window --class "Vivaldi-instance3" $window_id

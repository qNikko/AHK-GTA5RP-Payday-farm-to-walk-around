#NoEnv
#SingleInstance, Force
SendMode Input

; Настройки клавиш
startKey := "F1"      ; Клавиша запуска скрипта
stopKey := "F2"       ; Клавиша остановки скрипта
forwardKey := "w"     ; Клавиша движения вперед
sideKey := "a"        ; Клавиша движения влево (для круга)

; Флаг активности скрипта
isRunning := false

; Бинд запуска
Hotkey, %startKey%, StartCircle
; Бинд остановки
Hotkey, %stopKey%, StopCircle

return

StartCircle:
    if (!isRunning)
    {
        isRunning := true
        ; Зажимаем движение вперед и влево
        Send {%forwardKey% down}
        Send {%sideKey% down}
        ToolTip, Скрипт активен - движение по кругу
    }
return

StopCircle:
    if (isRunning)
    {
        isRunning := false
        ; Отпускаем все клавиши
        Send {%forwardKey% up}
        Send {%sideKey% up}
        ToolTip, Скрипт остановлен
        Sleep, 1000
        ToolTip
    }
return

; Экстренная остановка при нажатии Escape
~Escape::
    if (isRunning)
    {
        Gosub, StopCircle
    }
return

; Авто-остановка при переключении окна
#If, isRunning
~LButton::
~Alt::
    Gosub, StopCircle
return
#If
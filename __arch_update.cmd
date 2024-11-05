cd /d d:\projects\
  REM ac            Снять атрибут "Архивный" после архивации/извлечения
  REM ag[формат]    Добавить текущие дату и время к имени архива
  REM ao            Добавить файлы с установленным атрибутом "Архивный"
  REM ed            Не добавлять пустые каталоги
::c:\progra~1\winrar\rar a -ac -agyyyy-mm-dd_hh-mm .\Offtsql_ .\Offtsql
c:\progra~1\winrar\rar a -ac -ao -ed -x.\Offtsql\.git -agyyyy-mm-dd_hh-mm .\Offtsql_ .\Offtsql
pause

cd /d d:\projects\
  REM ac            Снять атрибут "Архивный" после архивации/извлечения
  REM ag[формат]    Добавить текущие дату и время к имени архива
  REM ao            Добавить файлы с установленным атрибутом "Архивный"
::c:\progra~1\winrar\rar a -ac -agyyyy-mm-dd_hh-mm .\Offtsql_ .\Offtsql
c:\progra~1\winrar\rar a -x.\Offtsql\.git -x.\Offtsql\arch -x.\Offtsql\bin -x.\Offtsql\doc -x.\Offtsql\ext -x.\Offtsql\ico -x*.rar -x*.exe -x*.sql -agyyyy-mm-dd_hh-mm .\Offtsql_ .\Offtsql
pause

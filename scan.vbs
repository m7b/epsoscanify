'Only naps.console:
'-i %File -n 0 -o "C:\Users\Public\Pictures\Scans\scan_$(YYYY)-$(MM)-$(DD)_$(hh)-$(mm)-$(ss).pdf" --ocrlang "deu+eng" & del %File
dim argument
if wscript.arguments.count > 0 then
    argument = wscript.arguments(0)
end if


Dim cmd
Dim fso
if Len(argument) > 0 then
    'cmd: naps2.console -i %1 -n 0 -o "C:\Users\Public\Pictures\Scans\scan_$(YYYY)-$(MM)-$(DD)_$(hh)-$(mm)-$(ss).pdf" --ocrlang "deu+eng"
    cmd = """C:\Program Files (x86)\NAPS2\NAPS2.Console.exe""" & " -i " & """" & argument & """" & " --verbose -n 0 -o ""C:\Users\Public\Pictures\Scans\scan_$(YYYY)-$(MM)-$(DD)_$(hh)-$(mm)-$(ss).pdf"" --ocrlang ""deu+eng"""
    set wshshell = CreateObject("WScript.Shell")
    wshshell.run cmd, 1, True

    'Delete source file
    Set fso = CreateObject("Scripting.FileSystemObject") 'Calls the File System Object
    fso.DeleteFile(argument) 'Deletes the file throught the DeleteFile function
end if


'WScript.Echo "The arguements you passed me are: " & cmd
'WScript.Quit


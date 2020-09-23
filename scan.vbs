'******************************************************************************
' File:    scan.vbs
' Author:  (c) M. Buttig
' Version: 1.0.0
'
' Description:
' ------------
' This vbs scripts takes the scanned TIFF image (single or multipage) which is
' passed as an argument. It creates a PDF file of that image with OCR into the
' same directory of the image. After creating the PDF file, it deletes the
' passed TIFF image.
'
' Version history:
' ----------------
' 1.0.0 - initial Version
'
'******************************************************************************

Dim path_NAPS_Console_exe

' Configure section
' -----------------
path_NAPS_Console_exe = "C:\Program Files (x86)\NAPS2\NAPS2.Console.exe"

' End configure section

Dim argument
Dim cmd
Dim fso

if wscript.arguments.count > 0 then
    argument = wscript.arguments(0)
end if

if Len(argument) > 0 then
    'The command line has to be in the form ...
    'cmd: NAPS2.Console -i %1 -n 0 -o "C:\Scans\scan_$(YYYY)-$(MM)-$(DD)_$(hh)-$(mm)-$(ss).pdf" --ocrlang "deu+eng"
	'%1 is the argument which is passed to this script. This shoud be the
	'scanned TIFF image.
	cmd = """" & path_NAPS_Console_exe & """" & " -i " & """" & argument & """" & " --verbose -n 0 -o ""C:\Scans\scan_$(YYYY)-$(MM)-$(DD)_$(hh)-$(mm)-$(ss).pdf"" --ocrlang ""deu+eng"""
    set wshshell = CreateObject("WScript.Shell")
    wshshell.run cmd, 1, True

    'Delete source file
    Set fso = CreateObject("Scripting.FileSystemObject") 'Calls the File System Object
    fso.DeleteFile(argument) 'Deletes the file throught the DeleteFile function
else
    WScript.Echo "The arguements you passed me are: " & argument
    WScript.Echo "NAPS executable is set to: " & path_NAPS_Console_exe	
end if

'*** End

'******************************************************************************
' File:    scan.vbs
' Author:  (c) M. Buttig
' Version: 1.0.1
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
' 1.0.1 - With configuring section
'
'******************************************************************************

Dim path_NAPS_Console_exe
Dim path_Dest_Dir_OcrPDF
Dim file_OcrPDF_Naming

' Configure section
' -----------------
path_NAPS_Console_exe = "C:\Program Files (x86)\NAPS2\NAPS2.Console.exe"
path_Dest_Dir_OcrPDF  = "C:\Scans"
file_OcrPDF_Naming    = "scan_$(YYYY)-$(MM)-$(DD)_$(hh)-$(mm)-$(ss).pdf"
'                               ^       ^     ^     ^     ^     ^
'                               |       |     |     |     |     +-- Second
'                               |       |     |     |     +-- Minute
'                               |       |     |     +--Hour
'                               |       |     +-- Day
'                               |       +-- Month
'                               +-- Year

' End configure section, NO CHANGES FROM HERE

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
	cmd = """" & path_NAPS_Console_exe & """" & " -i " & """" & argument & """" & " --verbose -n 0 -o """ & path_Dest_Dir_OcrPDF & "\" & file_OcrPDF_Naming & """ --ocrlang ""deu+eng"""
    set wshshell = CreateObject("WScript.Shell")
    wshshell.run cmd, 1, True

    'Delete source file
    Set fso = CreateObject("Scripting.FileSystemObject") 'Calls the File System Object
    fso.DeleteFile(argument) 'Deletes the file throught the DeleteFile function
else
    WScript.Echo "The arguements you passed me are: " & argument
    WScript.Echo "NAPS executable is set to:        " & path_NAPS_Console_exe
    WScript.Echo "path_Dest_Dir_OcrPDF:             " & path_Dest_Dir_OcrPDF
    WScript.Echo "file_OcrPDF_Naming:               " & file_OcrPDF_Naming
    WScript.Echo "----------------------------------"
    WScript.Echo "Full execution command: " & """" & path_NAPS_Console_exe & """" & " -i " & """" & argument & """" & " --verbose -n 0 -o """ & path_Dest_Dir_OcrPDF & "\" & file_OcrPDF_Naming & """ --ocrlang ""deu+eng"""
end if

'*** End

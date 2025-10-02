program HTMLToPDFConverter;

{*******************************************************************************
  HTML to PDF Converter
  
  Author: Alexander Buzaev
  Description: Example program demonstrating HTML to PDF conversion
               using TotalHTMLConverterX
  Requirements: 
    - Delphi 10.4+
    - TotalHTMLConverterX from https://www.coolutils.com/TotalHTMLConverterX
*******************************************************************************}

uses
  Vcl.Forms,
  Dialogs,
  SysUtils,
  uHTMLConverter in 'uHTMLConverter.pas';

{$R *.res}

procedure ConvertExample;
var
  Converter: THTMLConverter;
  SourceFile, DestFile, LogFile: string;
begin
  // Set file paths
  SourceFile := 'c:\test\source.html';
  DestFile := 'c:\test\dest.pdf';
  LogFile := 'c:\test\conversion.log';
  
  // Create converter instance
  Converter := THTMLConverter.Create;
  try
    // Perform conversion
    if Converter.ConvertHTMLToPDF(SourceFile, DestFile, LogFile) then
    begin
      ShowMessage('Conversion completed successfully!' + sLineBreak +
                  'PDF file: ' + DestFile);
    end
    else
    begin
      ShowMessage('Conversion failed!' + sLineBreak +
                  'Error: ' + Converter.LastError + sLineBreak +
                  'Check log file: ' + LogFile);
    end;
  finally
    Converter.Free;
  end;
end;

procedure SimpleConvertExample;
var
  c: OleVariant;
begin
  // Simple conversion example (original code style)
  try
    c := CreateOleObject('HTMLConverterPro.HTMLConverterX');
    c.Convert('c:\test\source.html', 'c:\test\dest.pdf', 
              '-c PDF -log c:\test\HTML.log');
    
    if c.ErrorMessage <> '' then
      ShowMessage('Error: ' + c.ErrorMessage)
    else
      ShowMessage('Conversion completed successfully!');
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  
  try
    // Use one of the examples:
    
    // Method 1: Using THTMLConverter class (recommended)
    ConvertExample;
    
    // Method 2: Simple direct conversion
    // SimpleConvertExample;
    
  except
    on E: Exception do
      ShowMessage('Application error: ' + E.Message);
  end;
end.
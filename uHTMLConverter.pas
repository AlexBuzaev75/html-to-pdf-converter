unit uHTMLConverter;

{*******************************************************************************
  HTML to PDF Converter Unit
  
  Author: Alexander Buzaev
  Description: Wrapper for TotalHTMLConverterX COM component
  Requirements: TotalHTMLConverterX from https://www.coolutils.com/TotalHTMLConverterX
  
  Usage:
    var
      Converter: THTMLConverter;
    begin
      Converter := THTMLConverter.Create;
      try
        if Converter.ConvertHTMLToPDF('source.html', 'dest.pdf', 'log.txt') then
          ShowMessage('Success!');
      finally
        Converter.Free;
      end;
    end;
*******************************************************************************}

interface

uses
  System.SysUtils, System.Variants, Dialogs, Vcl.OleAuto;

type
  THTMLConverter = class
  private
    FConverter: OleVariant;
    FLastError: string;
    FLogFile: string;
  public
    constructor Create;
    destructor Destroy; override;
    
    /// <summary>
    /// Converts HTML file to PDF format
    /// </summary>
    /// <param name="ASourceFile">Full path to source HTML file</param>
    /// <param name="ADestFile">Full path to destination PDF file</param>
    /// <param name="ALogFile">Full path to log file (optional)</param>
    /// <returns>True if conversion successful, False otherwise</returns>
    function ConvertHTMLToPDF(const ASourceFile, ADestFile: string; 
      const ALogFile: string = ''): Boolean;
    
    /// <summary>
    /// Returns last error message if conversion failed
    /// </summary>
    property LastError: string read FLastError;
    
    /// <summary>
    /// Path to log file
    /// </summary>
    property LogFile: string read FLogFile write FLogFile;
  end;

implementation

{ THTMLConverter }

constructor THTMLConverter.Create;
begin
  inherited;
  FLastError := '';
  FLogFile := '';
  
  try
    FConverter := CreateOleObject('HTMLConverterPro.HTMLConverterX');
  except
    on E: Exception do
    begin
      FLastError := 'Failed to create TotalHTMLConverterX object. ' +
                    'Please make sure TotalHTMLConverterX is installed. ' +
                    'Download from: https://www.coolutils.com/TotalHTMLConverterX. ' +
                    'Error details: ' + E.Message;
      raise Exception.Create(FLastError);
    end;
  end;
end;

destructor THTMLConverter.Destroy;
begin
  FConverter := Unassigned;
  inherited;
end;

function THTMLConverter.ConvertHTMLToPDF(const ASourceFile, ADestFile: string;
  const ALogFile: string = ''): Boolean;
var
  ConvertParams: string;
  LogPath: string;
begin
  Result := False;
  FLastError := '';
  
  try
    // Check if source file exists
    if not FileExists(ASourceFile) then
    begin
      FLastError := 'Source file not found: ' + ASourceFile;
      ShowMessage('Error: ' + FLastError);
      Exit;
    end;
    
    // Determine log file path
    if ALogFile <> '' then
      LogPath := ALogFile
    else if FLogFile <> '' then
      LogPath := FLogFile
    else
      LogPath := ChangeFileExt(ADestFile, '.log');
    
    // Prepare conversion parameters
    // -c PDF: output format is PDF
    // -log: path to log file
    ConvertParams := Format('-c PDF -log "%s"', [LogPath]);
    
    // Perform conversion
    FConverter.Convert(ASourceFile, ADestFile, ConvertParams);
    
    // Check for errors
    if VarToStr(FConverter.ErrorMessage) <> '' then
    begin
      FLastError := VarToStr(FConverter.ErrorMessage);
      ShowMessage('Conversion error: ' + FLastError);
      Exit;
    end;
    
    // Verify output file was created
    if not FileExists(ADestFile) then
    begin
      FLastError := 'Conversion completed but output file was not created: ' + ADestFile;
      ShowMessage('Warning: ' + FLastError);
      Exit;
    end;
    
    Result := True;
    
  except
    on E: Exception do
    begin
      FLastError := 'Exception during conversion: ' + E.Message;
      ShowMessage('Error: ' + FLastError);
    end;
  end;
end;

end.
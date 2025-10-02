# HTML to PDF Converter

Delphi project for converting HTML files to PDF format using TotalHTMLConverterX COM component.

## Requirements

- Delphi
- **TotalHTMLConverterX** installed on the system
  - Download from: https://www.coolutils.com/TotalHTMLConverterX
- Windows OS

## Description

This project provides a simple interface for converting HTML documents to PDF files using the TotalHTMLConverterX COM object from CoolUtils.

## Features

- HTML to PDF conversion
- Error handling and logging
- Support for various HTML sources
- Configurable conversion parameters
- Simple and clean code structure

## Installation

### Step 1: Install TotalHTMLConverterX

1. Download TotalHTMLConverterX from https://www.coolutils.com/TotalHTMLConverterX
2. Install and register the component on your system
3. Make sure the COM object is properly registered

### Step 2: Clone and Build Project

```bash
git clone https://github.com/yourusername/html-to-pdf-converter.git
cd html-to-pdf-converter
```

Open the project in Delphi 10.4 or later, build and run.

## Usage

### Basic Example

```pascal
uses
  Dialogs,
  Vcl.OleAuto;

var
  Converter: OleVariant;
begin
  Converter := CreateOleObject('HTMLConverter.HTMLConverterX');
  Converter.Convert('c:\test\source.html', 'c:\test\dest.pdf', '-c PDF -log c:\test\HTML.log');
  if Converter.ErrorMessage <> '' then
    ShowMessage(Converter.ErrorMessage);
end;
```

### Using THTMLConverter Class

```pascal
var
  Converter: THTMLConverter;
begin
  Converter := THTMLConverter.Create;
  try
    if Converter.ConvertHTMLToPDF('source.html', 'dest.pdf', 'conversion.log') then
      ShowMessage('Conversion completed!')
    else
      ShowMessage('Error: ' + Converter.LastError);
  finally
    Converter.Free;
  end;
end;
```

## Configuration

You can modify the following parameters in the Convert method:
- **Source HTML file path** - path to input HTML file
- **Destination PDF file path** - path to output PDF file
- **Conversion options:**
  - `-c PDF` - output format
  - `-log <path>` - log file path
  - Additional parameters supported by TotalHTMLConverterX

## Error Handling

The application checks for error messages returned by the converter and displays them using a message dialog. All errors are also logged to the specified log file.

## Project Structure

```
html-to-pdf-converter/
├── README.md
├── LICENSE
├── .gitignore
├── uHTMLConverter.pas       # Main converter unit
└── HTMLToPDFConverter.dpr   # Example program
```

## License

MIT License - see LICENSE file for details

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Author

**Alexander Buzaev**

## Acknowledgments

- CoolUtils for TotalHTMLConverterX component
- https://www.coolutils.com/TotalHTMLConverterX

## Support

For issues with TotalHTMLConverterX component, please refer to:
- Official documentation: https://www.coolutils.com/TotalHTMLConverterX
- CoolUtils support

For issues with this Delphi wrapper, please open an issue on GitHub.

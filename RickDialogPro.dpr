program RickDialogPro;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Rick.Dialog.Pro.Interf in 'src\Rick.Dialog.Pro.Interf.pas',
  Rick.Dialog.Pro.Types in 'src\Rick.Dialog.Pro.Types.pas',
  Rick.Dialog.Pro.Theme.Default.Colors in 'src\Theme\Rick.Dialog.Pro.Theme.Default.Colors.pas',
  Rick.Dialog.Pro.Theme.Default in 'src\Theme\Rick.Dialog.Pro.Theme.Default.pas',
  Rick.Dialog.Pro.Theme.Interf in 'src\Theme\Rick.Dialog.Pro.Theme.Interf.pas',
  Rick.Dialog.Pro.Impl.FMX in 'src\Impl\Rick.Dialog.Pro.Impl.FMX.pas',
  Rick.Dialog.Pro.Icons in 'src\Rick.Dialog.Pro.Icons.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

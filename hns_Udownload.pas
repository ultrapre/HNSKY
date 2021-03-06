unit hns_Udownload; {download file. See example https://wiki.lazarus.freepascal.org/fphttpclient}
                    {created 2019-9-5}
interface

uses
  classes,
  fphttpclient,
  openssl,
  opensslsockets; {in case of compile problems, temporary copy from fpc source the opensslsockets.pp and fpopenssl.pp from /home/h/fpc/packages/openssl/src to hnsky directory}

function download_file(url, filename:string):boolean;{download file}

implementation

function download_file(url, filename:string):boolean;{download file}
var
  Client: TFPHttpClient;
  FS: TStream;
  SL: TStringList;
begin
  result:=true;
  InitSSLInterface; { SSL initialization has to be done by hand here }
  Client := TFPHttpClient.Create(nil);
  FS := TFileStream.Create(Filename,fmCreate or fmOpenWrite);
  try
    try
      Client.AllowRedirect := true;{ Allow redirections }
      Client.Get(url,FS);
    except
  //    on E: EHttpClient do
  //    application.messagebox(pchar(E.Message),pchar(Error_string),0);
  //    else
  //    raise;
      result:=false;
    end;
    finally
      FS.Free;
      Client.Free;
  end;
end;

end.


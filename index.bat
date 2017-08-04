switch $CmdLine[0]
    Case 1 to 5
        $type=$CmdLine[1]
        $ip=$CmdLine[2]
        $port=$CmdLine[3]
        $proxyXML='<Address>'&$ip&'</Address>'&(at)CRLF& _
      '<Port>'&$port&'</Port>'&(at)CRLF& _
      '<Options>48</Options>'&(at)CRLF
    case 4 to 5
        $user=$CmdLine[4]
        $pass=$CmdLine[5]
        $proxyXML=$proxyXML&'<Authentication enabled="true">'&(at)CRLF& _
        '<Username>'&$user&'</Username>'&(at)CRLF& _
        '<Password>'&$pass&'</Password>'&(at)CRLF& _
      '</Authentication>'&(at)CRLF
EndSwitch

if NOT IsDeclared ( "proxyXML" ) Then Exit

; Prepare Proxyfier XML
$proxyfierXML='<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'&(at)CRLF& _
'<ProxifierProfile version="101" platform="Windows" product_id="1" product_minver="310">'&(at)CRLF& _
  '<Options>'&(at)CRLF& _
    '<Resolve>'&(at)CRLF& _
     ' <AutoModeDetection enabled="true" />'&(at)CRLF& _
      '<ViaProxy enabled="false">'&(at)CRLF& _
        '<TryLocalDnsFirst enabled="false" />'&(at)CRLF& _
      '</ViaProxy>'&(at)CRLF& _
     '<ExclusionList>%ComputerName%; localhost; *.local</ExclusionList>'&(at)CRLF& _
    '</Resolve>'&(at)CRLF& _
   '<ProxificationPortableEngine subsystem="32">'&(at)CRLF& _
      '<Location>BaseProvider</Location>'&(at)CRLF& _
      '<Type hotpatch="false">Modcopy</Type>'&(at)CRLF& _
    '</ProxificationPortableEngine>'&(at)CRLF& _
    '<ProxificationPortableEngine subsystem="64">'&(at)CRLF& _
      '<Location>Winsock</Location>'&(at)CRLF& _
      '<Type hotpatch="false">Prologue</Type>'&(at)CRLF& _
   ' </ProxificationPortableEngine>'&(at)CRLF& _
    '<Encryption mode="disabled" />'&(at)CRLF& _
    '<HttpProxiesSupport enabled="false" />'&(at)CRLF& _
    '<HandleDirectConnections enabled="false" />'&(at)CRLF& _
   ' <ConnectionLoopDetection enabled="true" />'&(at)CRLF& _
    '<ProcessServices enabled="false" />'&(at)CRLF& _
    '<ProcessOtherUsers enabled="false" />'&(at)CRLF& _
  '</Options>'&(at)CRLF& _
  '<ProxyList>'&(at)CRLF& _
    '<Proxy id="100" type="HTTPS">'&(at)CRLF& _
      $proxyXML&(at)CRLF& _
    '</Proxy>'&(at)CRLF& _
  '</ProxyList>'&(at)CRLF& _
  '<ChainList />'&(at)CRLF& _
  '<RuleList>'&(at)CRLF& _
    '<Rule enabled="true">'&(at)CRLF& _
      '<Name>Localhost</Name>'&(at)CRLF& _
      '<Targets>localhost; 127.0.0.1; %ComputerName%</Targets>'&(at)CRLF& _
      '<Action type="Direct" />'&(at)CRLF& _
    '</Rule>'&(at)CRLF& _
   ' <Rule enabled="true">'&(at)CRLF& _
      '<Name>Default</Name>'&(at)CRLF& _
      '<Action type="Proxy">100</Action>'&(at)CRLF& _
    '</Rule>'&(at)CRLF& _
  '</RuleList>'&(at)CRLF& _
'</ProxifierProfile>'

$proxyfierProfileFile=FileOpen("Profiles/IPswitchProfile"&$ip&".ppx",10)
FileWrite($proxyfierProfileFile,$proxyfierXML)
FileClose($proxyfierProfileFile)

;run Proxyfier
ShellExecute((at)ScriptDir&"\Proxifier.exe","Profiles\IPswitchProfile"&$ip&".ppx silent-load",(at)ScriptDir)

Do
Sleep(500)
until WinExists("IPswitchProfile")

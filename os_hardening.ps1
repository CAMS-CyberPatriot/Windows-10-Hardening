
Param(
    [switch] $NoAV
)

function RemoveApps(){
	#################################################################
	Write-Warning 'Removing bloatware...'
	[Array]$Apps =
		'Microsoft.3DBuilder',
		'Microsoft.Microsoft3DViewer',
		'Microsoft.Print3D',
		'Microsoft.Appconnector',
		'Microsoft.BingFinance',
		'Microsoft.BingNews',
		'Microsoft.BingSports',
		'Microsoft.BingTranslator',
		'Microsoft.BingWeather',
		'Microsoft.BingFoodAndDrink',
		'Microsoft.BingTravel',
		'Microsoft.BingHealthAndFitness',
		'Microsoft.FreshPaint',
		'Microsoft.MicrosoftOfficeHub',
		'Microsoft.WindowsFeedbackHub',
		'Microsoft.MicrosoftSolitaireCollection',
		'Microsoft.MicrosoftPowerBIForWindows',
		'Microsoft.MinecraftUWP',
		'Microsoft.MicrosoftStickyNotes',
		'Microsoft.NetworkSpeedTest',
		'Microsoft.Office.OneNote',
		'Microsoft.OneConnect',
		'Microsoft.People',
		'Microsoft.SkypeApp',
		'Microsoft.Wallet',
		'Microsoft.WindowsAlarms',
		'Microsoft.WindowsCamera',
		'Microsoft.windowscommunicationsapps',
		'Microsoft.WindowsMaps',
		'Microsoft.WindowsPhone',
		'Microsoft.WindowsSoundRecorder',
		'Microsoft.XboxApp',
		'Microsoft.XboxGameOverlay',
		'Microsoft.XboxIdentityProvider',
		'Microsoft.XboxSpeechToTextOverlay',
		'Microsoft.ZuneMusic',
		'Microsoft.ZuneVideo',
		'Microsoft.CommsPhone',
		'Microsoft.ConnectivityStore',
		'Microsoft.GetHelp',
		'Microsoft.Getstarted',
		'Microsoft.Messaging',
		'Microsoft.Office.Sway',
		'Microsoft.WindowsReadingList',
		'9E2F88E3.Twitter',
		'PandoraMediaInc.29680B314EFC2',
		'Flipboard.Flipboard',
		'ShazamEntertainmentLtd.Shazam',
		'king.com.CandyCrushSaga',
		'king.com.CandyCrushSodaSaga',
		'king.com.*',
		'ClearChannelRadioDigital.iHeartRadio',
		'4DF9E0F8.Netflix',
		'6Wunderkinder.Wunderlist',
		'Drawboard.DrawboardPDF',
		'2FE3CB00.PicsArt-PhotoStudio',
		'D52A8D61.FarmVille2CountryEscape',
		'TuneIn.TuneInRadio',
		'GAMELOFTSA.Asphalt8Airborne',
		'TheNewYorkTimes.NYTCrossword',
		'DB6EA5DB.CyberLinkMediaSuiteEssentials',
		'Facebook.Facebook',
		'flaregamesGmbH.RoyalRevolt2',
		'Playtika.CaesarsSlotsFreeCasino',
		'A278AB0D.MarchofEmpires',
		'KeeperSecurityInc.Keeper',
		'ThumbmunkeysLtd.PhototasticCollage',
		'XINGAG.XING',
		'89006A2E.AutodeskSketchBook',
		'D5EA27B7.Duolingo-LearnLanguagesforFree',
		'46928bounde.EclipseManager',
		'ActiproSoftwareLLC.562882FEEB491',
		'DolbyLaboratories.DolbyAccess',
		'A278AB0D.DisneyMagicKingdoms',
		'WinZipComputing.WinZipUniversal',
		'Microsoft.ScreenSketch',
		'Microsoft.XboxGamingOverlay',
		'Microsoft.Xbox.TCUI',
		'Microsoft.XboxGameCallableUI',
		'Microsoft.YourPhone'
	Foreach ($App in $Apps) {
		Get-AppxPackage $App | Remove-AppxPackage -AllUsers -ErrorAction 'SilentlyContinue'
	}
	Write-Host 'Done.'
}

# Disable NetBios
function DisableNetBios {
	Write-Warning("Disabling NetBios..")
	$key = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"
	Get-ChildItem $key | ForEach-Object {
     	Set-ItemProperty -Path "$key\$($_.pschildname)" -Name NetBiosOptions -Value 2
	}
	Write-Host("Done.")
}

# Disable AutoPlay and AutoRun
function DisableAutoPlayRun {
	Write-Warning "Disabling AutoPlay and AutoRun..."
	Set-RegistryValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoAutorun' -Value '1' -Type 'Dword' # Disables Autorun
	Set-RegistryValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoDriveTypeAutoRun' -Value '255' -Type 'Dword' # Disables Autorun
	Set-RegistryValue -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Name 'DisableAutoplay' -Value '1' -Type 'Dword' # Disables Autoplay
	Write-Host("Done.")
}

# Disable Find My Device
function DisableFindMyDevice {
	Write-Warning "Disabling Find My Device..."
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\FindMyDevice" -Name "AllowFindMyDevice" -Value 0 -Type Dword
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Settings\FindMyDevice" -Name "LocationSyncEnabled" -Value 0 -Type Dword
	Write-Host("Done.")
}

# Disable Win Insider Program
function DisableWinInsiderProgram {
	Write-Warning "Disabling Win Insider Program..."
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Name "AllowBuildPreview" -Value 0 -Type Dword
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Name "EnableConfigFlighting" -Value 0 -Type Dword
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ManagePreviewBuilds" -Value 1 -Type Dword
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ManagePreviewBuildsPolicyValue" -Value 0 -Type Dword
	Write-Host("Done.")
}

# Disable Active Desktop
function DisableActiveDesktop {
	Write-Warning "Disable Active Desktop..."
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ForceActiveDesktopOn" -Value 0 -Type Dword
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoActiveDesktop" -Value 1 -Type Dword
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoActiveDesktopChanges" -Value 1 -Type Dword
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" -Name "NoAddingComponents" -Value 1 -Type Dword
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" -Name "NoComponents" -Value 1 -Type Dword
	Write-Host("Done.")
}

# Disable Picture Password
function DisablePicturePassword {
	Write-Warning "Disable Picture Password..."
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "BlockDomainPicturePassword" -Value 1 -Type Dword
	Write-Host("Done.")
}

# Enable Enhanced Face Spoofing Protection
function EnableEnhancedFaceSpoofingProtection {
	Write-Warning "Enable Enhanced Face Spoofing Protection..."
	Set-RegistryValue -Name "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures" -Name "EnhancedAntiSpoofing" -Value 1 -Type Dword
	Write-Host("Done.")
}

# Disable Link-Local Multicast Name Resolution (LLMNR) protocol
function DisableLLMNR {
	Write-Warning "Disabling LLMNR..."
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Type DWord -Value 0
	Write-Host("Done.")
}

# Disable SMB Server - Completely disables file and printer sharing, but leaves the system able to connect to another SMB server as a client
function DisableSMBServer {
	Write-Warning "Disabling SMB Server..."

	Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
	Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
	Set-SmbServerConfiguration -EnableSMB2Protocol $false -Force
	Set-RegistryValue -Path "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\" -Name SMBDeviceEnabled -Value 0 -Type Dword

	Write-Host("Done.")
}

# Disable sharing mapped drives between users
function DisableSharingMappedDrives {
	Write-Warning "Disabling sharing mapped drives between users..."
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -ErrorAction SilentlyContinue
	Write-Host("Done.")
}

# Disable implicit administrative shares
function DisableAdminShares {
	Write-Warning "Disabling implicit administrative shares..."
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -Type DWord -Value 0
 	Write-Host("Done.")
}

# Disable Advertising ID
function DisableAdvertisingID {
	Write-Warning "Disabling Advertising ID..."
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "Enabled" -Type DWord -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
 	Write-Host("Done.")
}

# Disable Feedback
function DisableFeedback {
	Write-Warning "Disabling Feedback..."
	Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Assistance\Client\1.0" -Name "NoExplicitFeedback" -Type DWord -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Assistance\Client\1.0" -Name "NoImplicitFeedback" -Type DWord -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Assistance\Client\1.0" -Name "NoOnlineAssist" -Type DWord -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" -Name "NoActiveHelp" -Type DWord -Value 1

	Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
	Write-Host("Done.")
}

function DisableBackgroundApps {
	Write-Warning "Disabling Background application access..."
	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
		Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
		Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
	}
	Write-Host("Done.")
}

function DisableWebSearch {
	Write-Warning "Disabling Web Search..."
	Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0     # Disables Bing search
	Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
	Write-Host("Done.")
}

function EnableSmartScreen(){
	Write-Warning "Enabling SmartScreen Filter..."
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 1
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 1
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -Type Dword -Value 1

    # Disable SmartScreen
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
	# Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -Type Dword -Value 0
	Write-Host("Done.")
}

function DisableTelemetry {
	Write-Warning "Disabling Telemetry..."
	Set-RegistryValue -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type Dword -Value 0
	Set-RegistryValue -Path "Registry::HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type Dword -Value 0
	Set-RegistryValue -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type Dword -Value 0
	Set-RegistryValue -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Name "AllowBuildPreview" -Type Dword -Value 0
	Set-RegistryValue -Path "Registry::HKCU\Software\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type Dword -Value 0
    Set-RegistryValue -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name"AITEnable" -Type Dword -Value 0
    Set-RegistryValue -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "LimitEnhancedDiagnosticDataWindowsAnalytics" -Type Dword -Value 0
	Set-RegistryValue -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type Dword -Value 1

	Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
 	Write-Host("Done.")
}

function DisableServices(){
	#################################################################
	Write-Warning 'Disabling Unneeded Windows services...'
	[Array]$Services =
		'lmhosts', # TCP/IP NetBIOS Helper
		#'wlidsvc', # Microsoft Account Sign-in Assistant
		'SEMgrSvc', # Payments NFC/SE Manager
		'tzautoupdate', # Auto Time Zone Updater
		'AppVClient', # Microsoft App-V Client
		'RemoteRegistry', # Remote Registry
		'RemoteAccess', # Routing & Remote Access
		'shpamsvc', # Shared PC Account Manager
		'UevAgentService', # User Experience Virtualization Service
		'WdiServiceHost', # Diagnostic Service Host
		'WdiSystemHost', # Diagnostic System Host
		'ALG', # Application Layer Gateway
		'PeerDistSvc', # BranchCache
		'Eaphost', # Extensible Authentication Protocol
		'fdPHost', # function Discovery Provider Host
		'LxpSvc', # Language Experience Service
		'lltdsvc', # Link-Layer Topology Discovery Mapper
		'diagnosticshub.standardcollector.service', # Microsoft (R) Diagnostics Hub Standard Collector Service
		'MSiSCSI', # Microsoft iSCSI Initiator Service
		'WpcMonSvc', # Parental Control
		'PNRPsvc', # Peer Name Resolution Protocol
		'p2psvc', # Peer Networking Grouping
		'p2pimsvc', # Peer Networking Identity Manager
		'PerfHost', # Performance Counter DLL Host
		'pla', # Performance Logs & Alerts
		'PNRPAutoReg', # PNRP Machine Name Publication
		'PrintNotify', # PrintNotify
		'wercplsupport', # Problem Reports & Solutions Control Panel
		'TroubleshootingSvc', # Recommended Troubleshooting Service
		'SessionEnv', # Remote Desktop Configuration
		'TermService', # Remote Desktop Service
		'UmRdpService', # Remote Desktop Services UserMode Port Redirector
		'RpcLocator', # Remote Procedure Call (RPC) Locator
		'RetailDemo', # Retail Demo Service
		'SCPolicySvc', # Smart Card Removal Policy
		'SNMPTRAP', # SNMP Trap
		'SharedRealitySvc', # Spatial Data Service
		'WiaRpc', # Still Image Acquisition Events
		'VacSvc', # Volumetric Audio Compositor Service
		'WalletService', # WalletService
		'wcncsvc', # Windows Connect Now
		'Wecsvc', # Windows Event Collector
		'perceptionsimulation', # Windows Perception Simulation Service
		'WinRM', # Windows Remote Management (WS-Management)
		'wmiApSrv', # WMI Performance Adapter
		'WwanSvc', # WWAN AutoConfig
		'XblAuthManager', # Xbox Live Auth Manager
		'XboxNetApiSvc', # Xbox Live Networking Service
		'RasAuto', # Remote Access Auto Connection Manager
		'XblGameSave', # Xbox Live Game Save
		'XboxGipSvc', # Xbox Accessory Management
		'PushToInstall', # Windows PushToInstall Service
		'spectrum', # Windows Perception Service
		'icssvc', # Windows Mobile Hotspot Service
		'wisvc', # Windows Insider Service
		'WerSvc', # Windows Error Reporting Service
		'dmwappushservice', # Device Management Wireless Application Protocol (WAP) Push message Routing Service
		'FrameServer', # Windows Camera Frame Service
		'WFDSConMgrSvc', # Wi-Fi Direct Services Connection Manager Service
		'ScDeviceEnum', # Smart Card Device Enumeration Service
		'SCardSvr', # Smart Card
		'PhoneSvc', # Phone Service
		'IpxlatCfgSvc', # IP Translation Configuration Service
		'SharedAccess', # Internet Connection Sharing (ICS)
		'vmicvss', # Hyper-V Volume Shadow Copy Requestor
		'vmictimesync', # Hyper-V TIme Synchronization Service
		'vmicrdv', # Hyper-V Remote Desktop Virtualization Service
		'vmicvmsession', # Hyper-V PowerShell Direct Service
		'vmicheartbeat', # Hyper-V Heartbeat Service
		'vmicshutdown', # Hyper-V Guest Shudown Service
		'vmicguestinterface', # Hyper-V Guest Service Interface
		'vmickvpexchange', # Hyper-V Data Exchange Service
		'HvHost', # HV Host Service
		'FDResPub', # function Discovery Resource Publication
		'diagsvc', # Diagnostic Execution Service
		'autotimesvc', # Cellular Time
		'bthserv', # Bluetooth Support Service
		'BTAGService', # Bluetooth Audio Gateway Service
		'AssignedAccessManagerSvc', # AssignedAccessManager Service
		'AJRouter', # AllJoyn Router Service
		'lfsvc', # Geolocation Service
		'CDPSvc', # Connected Devices Platform Service
		'DiagTrack', # Connected User Experiences and Telemetry
		'DPS', # Diagnostic Policy Service
		'iphlpsvc', # IP Helper
		'RasMan', # Remote Access Connection Manager
		'SstpSvc', # Secure Socket Tunneling Protocol Service
		'ShellHWDetection', # Shell Hardware Detection
		'SSDPSRV', # SSDP Discovery
		'WbioSrvc', # Windows Biometric Service
		'stisvc', # Windows Image Acquisition (WIA)
		'MessagingService', # Instant messaging Universal Windows Platform Service
		'PcaSvc' # Program Compatibility Assistant (PCA)
	Foreach ($Service in $Services) {
		Set-Service -Name $Service -StartupType 'Disabled'
		Stop-Service -Name $Service -Force
	}
	Write-Host 'Done.'
}

function EnableTLS1_2(){
	Write-Warning 'Enabling TLSv1.2...'
	Set-Variable -Name 'Path' -Value 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols'
	Set-Variable -Name 'Protocol' -Value 'TLS 1.2'

	if (!(Test-Path "$Path\$Protocol")){
		New-Item -Path $Path -Name $Protocol -Type 'Directory' -ErrorAction 'SilentlyContinue'
	}

	Set-Variable -Name 'key' -Value $Path\$Protocol
	Set-RegistryValue -Path $key -Name 'Client' -Type 'Directory'
	Set-RegistryValue -Path $key -Name 'Server' -Type 'Directory'

	Set-RegistryValue -Path "$key\Client" -Name "DisabledByDefault" -Value "0" -Type 'Dword'
	Set-RegistryValue -Path "$key\Client" -Name "Enabled" -Value "1" -Type 'Dword'
	Set-RegistryValue -Path "$key\Server" -Name "DisabledByDefault" -Value "0" -Type 'Dword'
	Set-RegistryValue -Path "$key\Server" -Name "Enabled" -Value "1" -Type 'Dword'


	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp' -Name 'DefaultSecureProtocols' -Value '0x800' -Type 'Dword'
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp' -Name 'DefaultSecureProtocols' -Value '0x800' -Type 'Dword'
	Set-RegistryValue -Path 'Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name 'SecureProtocols' -Value '0x800' -Type 'Dword'
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'chUseStrongCrypto' -Value '1' -Type 'Dword'
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'chUseStrongCrypto' -Value '1' -Type 'Dword'
	Write-Host 'Done.'
}

function DisableNetSecProtocols(){
	#################################################################
	Write-Warning 'Disabling unsafe network protocols...'
	Set-Variable -Name 'Path' -Value 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols'
	$Protocols = @('DTLS 1.0', 'PCT 1.0', 'SSL 2.0', 'SSL 3.0', 'TLS 1.0', 'TLS 1.1')
	Foreach ($Protocol in $Protocols) {
		if(!(Test-Path "$Path\$Protocol")){
            New-Item -Path $Path -Name $Protocol -Type 'Directory'
        }
		Set-Variable -Name 'key' -Value $Path\$Protocol
        Set-RegistryValue -Path $key -Name 'Client' -Type 'Directory'
	    Set-RegistryValue -Path $key -Name 'Server' -Type 'Directory'

        Set-RegistryValue -Path "$key\Client" -Name "DisabledByDefault" -Value "1" -Type 'Dword'
        Set-RegistryValue -Path "$key\Client" -Name "Enabled" -Value "0" -Type 'Dword'
        Set-RegistryValue -Path "$key\Server" -Name "DisabledByDefault" -Value "1" -Type 'Dword'
        Set-RegistryValue -Path "$key\Server" -Name "Enabled" -Value "0" -Type 'Dword'
	}
	Write-Host 'Done.'

    # Enable TLS 1.2
	EnableTLS1_2
}

function DisableNetworks(){
	Write-Warning 'Disabling unnecessary network connections...'
	
	#Get-NetAdapter -Name '*' | Set-DNSClient -Interface $_ -RegisterThisConnectionsAddress $FALSE # Disables 'Register this connection's addresses in DNS'
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_lldp' # Microsoft LLDP Protocol Driver
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_implat' # Microsoft Network Adapter Multiplexor Protocol
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_lltdio' # Link-Layer Topology Discovery Mapper I/O Driver
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_server' # File and Printer Sharing for Micorsoft Networks
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_rspndr' # Link-Layer Topology Discovery Responder
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_msclient' # Client for Microsft Networks
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_pacer' # QoS a Scheduler	

	Write-Host 'Done.'
}

function DisableIPv6(){
	Write-Warning 'Disabling IPv6...'
	
	Set-RegistryValue -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters' -Name 'DisabledComponents' -Value '0xFF' -Type 'Dword' # Disables IPv6 completely
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_tcpip6' # Internet Protocol Version 6 (TCP/IPv6)

	Write-Host 'Done.'
}

function FlushCaches(){
	#################################################################
	Write-Warning 'Flushing caches...'
	Ipconfig /flushdns
	netsh interface ipv4 delete arpcache
	netsh interface ipv4 delete destinationcache
	netsh interface ipv4 delete neighbors
	Set-Variable -Name 'Adapter' -Value (Get-NetAdapter -Name 'Ethernet*' -Physical | Select-Object -ExpandProperty 'Name')
	netsh interface ipv4 delete winsservers $Adapter all
	Remove-Item -Path "$env:SystemRoot\System32\drivers\etc\hosts" -force
	New-Item -Path "$env:SystemRoot\System32\drivers\etc" -Name 'hosts' -ItemType 'file' -Value '# Flushed.' -Force
	Write-Host 'Done.'
}

function DisableWiFiSense(){
	# Disable Wi-Fi Sense
	Write-Warning "Disabling Wi-Fi Sense..."

	Set-RegistryValue -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
	Set-RegistryValue -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0

	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -Type Dword -Value 0
	Write-Host("Done.")
}

function DisableScheduledTasks(){
	Write-Warning "Disabling unneeded scheduled tasks"

	# Disable Customer Experience Improvement Program (CEIP) tasks.
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Autochk\Proxy" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\PI\Sqm-Tasks" | Out-Null
	

	# Disable setting sync tasks.
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\SettingSync\BackgroundUploadTask" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\SettingSync\BackupTask" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\SettingSync\NetworkStateChangeTask" | Out-Null


	# Disable Windows Error Reporting task.
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null

	# Disable Office subscription heartbeat task.
	Disable-ScheduledTask -TaskName "\Microsoft\Office\Office 15 Subscription Heartbeat" | Out-Null

	# Disable SmartScreen data collection task.
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\AppID\SmartScreenSpecific" | Out-Null
	
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\AitAgent" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\DiskFootprint\Diagnostics" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Maintenance\WinSAT" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\PI\Sqm-Tasks" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Shell\FamilySafetyMonitor" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Shell\FamilySafetyRefresh" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Shell\FamilySafetyUpload" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Shell\FamilySafetyMonitor" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Shell\FamilySafetyMonitorToastTask" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\WindowsUpdate\Automatic App Update" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\License Manager\TempSignedLicenseExchange" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Clip\License Validation" | Out-Null

	Disable-ScheduledTask -TaskName "\Microsoft\Windows\ApplicationData\DsSvcCleanup" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\PushToInstall\LoginCheck" | Out-Null

	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\Diagnosis\Scheduled" | Out-Null
	Disable-ScheduledTask -TaskName "\Microsoft\Windows\NetTrace\GatherNetworkInfo" | Out-Null
    
	Write-Host "Done."
}

function Office_hardening(){
	Write-Warning "Starting Office hardening"

	# Blocks macros and other content execution (Office >= 2016)
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\access\security' -Name 'vbawarnings' -Type Dword -Value 4    
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\excel\security' -Name 'vbawarnings' -Value '4' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\excel\security' -Name 'blockcontentexecutionfrominternet' -Value '1' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\excel\security' -Name 'excelbypassencryptedmacroscan' -Value '0' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\ms project\security' -Name 'vbawarnings' -Value '4' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\ms project\security' -Name 'level' -Value '4' -Type 'Dword'  
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\security' -Name 'level' -Value '4' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\powerpoint\security' -Name 'vbawarnings' -Value '4' -Type 'Dword'  
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\powerpoint\security' -Name 'blockcontentexecutionfrominternet' -Value '1' -Type 'Dword'  
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security' -Name 'vbawarnings' -Value '4' -Type 'Dword'  
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\visio\security' -Name 'vbawarnings' -Value '4' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\visio\security' -Name 'blockcontentexecutionfrominternet' -Value '1' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\word\security' -Name 'vbawarnings' -Value '4' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\word\security' -Name 'blockcontentexecutionfrominternet' -Value '1' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\word\security' -Name 'wordbypassencryptedmacroscan' -Value '0' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\Common\security' -Name 'automationsecurity' -Value '3' -Type 'Dword'
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\options\mail' -Name 'blockextcontent' -Value '1' -Type 'Dword' 
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\options\mail' -Name 'junkmailenablelinks' -Value '0' -Type 'Dword' 


	# Disable DDE Execution (Excel, Outlook, Word >= Office 2016)
	Set-RegistryValue -Path 'HKCU:\Software\Microsoft\Office\16.0\Excel\Security' -Name 'WorkbookLinkWarnings' -Value '2' -Type 'Dword'
	Set-RegistryValue -Path 'HKCU:\Software\Microsoft\Office\16.0\Word\Options\WordMail' -Name 'DontUpdateLinks' -Value '1' -Type 'Dword'
	Set-RegistryValue -Path 'HKCU:\Software\Microsoft\Office\16.0\Word\Options' -Name 'DontUpdateLinks' -Value '1' -Type 'Dword'
	

	# Disable Feedback in Office.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\Feedback" -Name "Enabled" -Type Dword -Value 0
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\Feedback" -Name "IncludeScreenshot" -Type Dword -Value 0

	# Disable data collection and telemetry in Office.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\general" -Name "notrack" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\general" -Name "optindisable" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\general" -Name "shownfirstrunoptin" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\ptwatson" -Name "ptwoptin" -Type Dword -Value 0
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\firstrun" -Name "bootedrtm" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\firstrun" -Name "disablemovie" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm" -Name "enablefileobfuscation" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm" -Name "enablelogging" -Type Dword -Value 0
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm" -Name "enableupload" -Type Dword -Value 0
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "accesssolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "olksolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "onenotesolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "pptsolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "projectsolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "publishersolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "visiosolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "wdsolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedapplications" -Name "xlsolution" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedsolutiontypes" -Name "agave" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedsolutiontypes" -Name "appaddins" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedsolutiontypes" -Name "comaddins" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedsolutiontypes" -Name "documentfiles" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm\preventedsolutiontypes" -Name "templatefiles" -Type Dword -Value 1
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\Outlook\Options\Mail' -Name 'EnableLogging' -Type Dword -Value 0
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\Word\Options' -Name 'EnableLogging' -Type Dword -Value 0
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\Common\ClientTelemetry' -Name 'DisableTelemetry' -Type Dword -Value 1


	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Office\16.0\Common\Services\Fax' -Name 'NoFax' -Type Dword -Value 1 # Disables online Fax services

	# Disable saving/login to OneDrive in Office.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\General" -Name "skydrivesigninoption" -Type Dword -Value 0
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\Signin" -Name "signinoptions" -Type Dword -Value 3

	# Prevent Office from connecting to the Internet.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Common\Internet" -Name "UseOnlineContent" -Type Dword -Value 0

	# Security - Enable automatic updates for Office.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Office\16.0\Common\officeupdate" -Name "EnableAutomaticUpdates" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Office\16.0\Common\officeupdate" -Name "HideEnableDisableUpdates" -Type Dword -Value 1

	# Disable Online Repair in Office.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Office\16.0\Common\officeupdate" -Name "OnlineRepair" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Office\16.0\Common\officeupdate" -Name "fallbacktocdn" -Type Dword -Value 0

	Write-Host "Done."
}

function RDP_hardening(){
	# Disable and configure Windows Remote Desktop and Remote Desktop Services.
	
	# Disable Remote Desktop
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "fDenyTSConnections" -Type Dword -Value 1

	# Disable Remote Assistance and don't allow unsolicited remote assistance offers
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "fAllowToGetHelp" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "fAllowUnsolicited" -Type Dword -Value 0
	
	# Disable Remote Desktop Sharing
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Conferencing" -Name "NoRDS" -Type Dword -Value 1
	
	# Disable password saving 
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Windows NT\Terminal Services" -Name "DisablePasswordSaving" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "DisablePasswordSaving" -Type Dword -Value 1
	
	# Prevent the client to run signed and unsigned .rdp files
	<#
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Windows NT\Terminal Services" -Name "AllowSignedFiles" -Type Dword -Value 0
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Windows NT\Terminal Services" -Name "AllowUnsignedFiles" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "AllowSignedFiles" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "AllowUnsignedFiles"-Type Dword -Value 0
	#>

	# Only connect to same version or higher
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "CreateEncryptedOnlyTickets" -Type Dword -Value 1
	
	# Do not allow Remote Shell Access
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS" -Name "AllowRemoteShellAccess" -Type Dword -Value 0

	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\RemoteAdminSettings" -Name "Enabled" -Type Dword -Value 0
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\Services\RemoteDesktop" -Name "Enabled" -Type Dword -Value 0
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\Services\UPnPFramework" -Name "Enabled" -Type Dword -Value 0
}

function Edge_hardening(){

	Write-Warning "Starting Edge Hardening..."

	# Disable Flash player in Edge.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Addons" -Name "FlashPlayerEnabled" -Value '0' -Type 'Dword'

	# Send the Do Not Track (DNT) request header in Edge.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Main" -Name "DoNotTrack" -Value '1' -Type 'Dword'

	# Disable third-party cookies in Edge.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Main" -Name "Cookies" -Value '1' -Type 'Dword'

	# Prevent data collection in Edge, and generally improve privacy.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Main" -Name "PreventLiveTileDataCollection" -Value '1' -Type 'Dword'
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Name "DisableMFUTracking" -Value '1' -Type 'Dword'
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Name "DisableRecentApps" -Value '1' -Type 'Dword'
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Name "TurnOffBackstack" -Value '1' -Type 'Dword'

	# Enable Edge phishing filter.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Value '1' -Type 'Dword'
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Value '1' -Type 'Dword'

	# Disable Edge phishing filter.
	# Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type Dword -Value 0

	# Clear browsing history on exit in Edge.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Privacy" -Name "ClearBrowsingHistoryOnExit" -Value '1' -Type 'Dword'
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Privacy" -Name "ClearBrowsingHistoryOnExit" -Value '1' -Type 'Dword'

	# Disable help prompt in Edge UI.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Windows\EdgeUI" -Name "DisableHelpSticker" -Value '1' -Type 'Dword'
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" -Name "DisableHelpSticker" -Value '1' -Type 'Dword'

	# Disable search suggestions in Edge.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\SearchScopes" -Name "ShowSearchSuggestionsGlobal" -Value '0' -Type 'Dword'

	Write-Host "Done."
}

function IE_hardening(){
	Write-Warning "Starting IE hardening..."

	# Disable Geolocation in Internet Explorer.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\Geolocation" -Name "PolicyDisableGeolocation" -Type Dword -Value 1

	# Enable Internet Explorer phishing filter.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\PhishingFilter" -Name "EnabledV9" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\PhishingFilter" -Name "EnabledV9" -Type Dword -Value 1

	# Disable Internet Explorer phishing filter.
	# Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\PhishingFilter" -Name "EnabledV9" -Type Dword -Value 0
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\PhishingFilter" -Name "EnabledV9" -Type Dword -Value 0

	# Disable Internet Explorer InPrivate logging.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\Safety\PrivacIE" -Name "DisableLogging" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Safety\PrivacIE" -Name "DisableLogging" -Type Dword -Value 1

	# Disable Internet Explorer CEIP.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\SQM" -Name "DisableCustomerImprovementProgram" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\SQM" -Name "DisableCustomerImprovementProgram" -Type Dword -Value 0

	# Disable enhanced, and other suggestions.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Name "AllowServicePoweredQSA" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\DomainSuggestion" -Name "Enabled" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\SearchScopes" -Name "TopResult" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" -Name "Enabled" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "AutoSearch" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main\WindowsSearch" -Name "EnabledScopes" -Type Dword -Value 0

	# Disable continuous browsing.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\ContinuousBrowsing" -Name "Enabled" -Type Dword -Value 0

	# Enable DEP and isolation in Internet Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DEPOff" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "Isolation64Bit" -Type Dword -Value 1

	# Disable prefetching in Internet Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\PrefetchPrerender" -Name "Enabled" -Type Dword -Value 0

	# Disable crash detection in Internet Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Restrictions" -Name "NoCrashDetection" -Type Dword -Value 1

	# Send the Do Not Track (DNT) request header in Internet Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DoNotTrack" -Type Dword -Value 1

	# Clear browsing history on exit in Internet Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Privacy" -Name "ClearBrowsingHistoryOnExit" -Type Dword -Value 1

	# Disable SSLv3 fallback, and the ability to ingore certificate errors, in Internet Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "CallLegacyWCMPolicies" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "EnableSSL3Fallback" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "PreventIgnoreCertErrors" -Type Dword -Value 1

	# Force enabled HTTP/2 in Internet Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "EnableHTTP2" -Type Dword -Value 1

	Write-Host "Done."
}

function Misc(){

	# Explorer Stuffs
	# ExplorerStuffs

	# Disable both AutoRun and AutoPlay
	DisableAutoPlayRun

	# Disable FindMyDevice
	DisableFindMyDevice

	# Disable Insider Program PreviewBuild
	DisableWinInsiderProgram

	# Disable Active Desktop
	DisableActiveDesktop

	# Disable PicturePassword Sign-In
	DisablePicturePassword

	# Enanche face spoofing protection
	EnableEnhancedFaceSpoofingProtection

	# Disables password reveal button
	Set-RegistryValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main' -Name 'DisablePasswordReveal' -Value '1' -Type 'Dword'        
	# Disables password display button
	Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\Windows\CredUI' -Name 'DisablePasswordReveal' -Value '1' -Type 'Dword'                

<#
	# Privacy & Security - Only download Windows Updates from LAN peers, and Microsoft servers.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 1 /f

	# Security - Disable projecting (Connect) to the device, and require a pin for pairing.
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'AllowProjectionToPC' -Value '0' -Type 'Dword'  # Disables projecting (Connect) to the device and requires a pin for pairing
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'RequirePinForPairing' -Value '1' -Type 'Dword' # Disables projecting (Connect) to the device and requires a pin for pairing
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Policies\Microsoft\WirelessDisplay' -Name 'EnforcePinBasedPairing' -Value '1' -Type 'Dword' # Disables projecting (Connect) to the device and requires a pin for pairing
	Set-RegistryValue -Path 'Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\PresentationSettings' -Name 'NoPresentationSettings' -Value '1' -Type 'Dword' # Disables projecting (Connect) to the device and requires a pin for pairing

	# Security - Disable Mobile Device Management (MDM) enrollment.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM" /v "DisableRegistration" /t REG_DWORD /d 1 /f

	# Security - Force enable Data Execution Prevention (DEP).
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoDataExecutionPrevention" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableHHDEP" /t REG_DWORD /d 0 /f

	# Security - Disable desktop Gadgets.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /v "TurnOffSidebar" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /v "TurnOffUnsignedGadgets" /t REG_DWORD /d 1 /f

	# Security - Force process digital certificates when running executables.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers" /v "authenticodeenabled" /t REG_DWORD /d 1 /f
	
	# Security - Disable pushing of apps for installation from the Windows store.
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Policies\Microsoft\PushToInstall' -Name 'DisablePushToInstall' -Value '1' -Type 'Dword' # Disables pushing of apps for installation from the Windows store

	# Security - Disable Windows Update deferrals.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdates" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferQualityUpdates" /t REG_DWORD /d 0 /f

	# Privacy - Disable CEIP for apps, and generally.
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP' -Name 'CEIPEnable' -Value '0' -Type 'Dword' # Disables CEIP for apps and generally
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows' -Name 'CEIPEnable' -Value '0' -Type 'Dword' # Disables CEIP for apps and generally

	# Privacy - Disable the Network Connectivity Status Indicator.
	# reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "DisablePassivePolling" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d 1 /f

	# Privacy - Prevent Search Companion from downloading files from Microsoft.
	Set-RegistryValue -Path 'Registry::HKLM\SOFTWARE\Policies\Microsoft\SearchCompanion' -Name 'DisableContentFileUpdates' -Value '1' -Type 'Dword' # Disables pushing of apps for installation from the Windows store

	# Privacy - Disable app access to user advertising information.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f


	# Privacy - Disable and configure Windows Error Reporting.
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "ForceQueueMode" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /v "DWNoExternalURL" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /v "DWNoFileCollection" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /v "DWNoSecondLevelCollection" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" /v "Headlines" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" /v "MicrosoftKBSearch" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSendGenericDriverNotFoundToWER" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSendRequestAdditionalSoftwareToWER" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d 1 /f

	# Privacy - Disable metadata retrieval in Windows Media Player.
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventCDDVDMetadataRetrieval" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventMusicFileMetadataRetrieval" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\WindowsMediaPlayer" /v "PreventRadioPresetsRetrieval" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f


	# Privacy - Disable setting sync.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "EnableBackupForWin8Apps" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Messaging" /v "AllowMessageSync" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t REG_DWORD /d 1 /f
	# Privacy - Disable app syncing.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.BingFinance_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.BingMaps_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.BingNews_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.BingSports_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.BingTravel_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.BingWeather_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.Reader_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.XboxLIVEGames_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.ZuneMusic_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration\Windows8AppList\Microsoft.ZuneVideo_8wekyb3d8bbwe" /v "SyncSettings" /t REG_DWORD /d 0 /f

	# Privacy - Disable location and sensors.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f

	# Privacy - Disable the Windows Connect Now wizard.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "DisableFlashConfigRegistrar" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "DisableInBand802DOT11Registrar" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "DisableUPnPRegistrar" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "DisableWPDRegistrar" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /v "EnableRegistrars" /t REG_DWORD /d 0 /f
	Set-RegistryValue -Path 'Registry::HKCU\Software\Policies\Microsoft\Windows\WCN\UI' -Name 'DisableWcnUi' -Value '1' -Type 'Dword' # Disables Windows Connect Now wizard

	# Privacy - Disable device metadata retrieval from the Internet.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f

	# Privacy - Disable and configure Windows Spotlight for privacy.
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "ConfigureWindowsSpotlight" /t REG_DWORD /d 2 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnActionCenter" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightWindowsWelcomeExperience" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "IncludeEnterpriseSpotlight" /t REG_DWORD /d 0 /f
	
	# Privacy - Disable (force deny) app access to personal data.
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessAccountInfo" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessEmail" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMicrophone" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMotion" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTasks" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTrustedDevices" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsGetDiagnosticInfo" /t REG_DWORD /d 2 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsSyncWithDevices" /t REG_DWORD /d 2 /f
#>
}

function ConfigureWinDef(){

	Write-Warning("Configuring Windows Defender..")

	# Security option - Enable Windows Defender.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "ServiceKeepAlive" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableIOAVProtection" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableBehaviorMonitoring" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" -Name "CheckForSignaturesBeforeRunningScan" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" -Name "DisableHeuristics" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "ScanWithAntiVirus"-Type Dword -Value 3

	# Privacy - Configure Windows Defender.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" -Name "LocalSettingOverrideSpynetReporting" -Type Dword -Value 0
	
	# Disable automatic sample submission
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" -Name "SpyNetReporting" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" -Name "SubmitSamplesConsent" -Type Dword -Value 2
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" -Name "DisableGenericRePorts" -Type Dword -Value 1
	
	# Privacy option - Disable Windows Defender.
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type Dword -Value 1
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "ServiceKeepAlive" -Type Dword -Value 0
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableIOAVProtection" -Type Dword -Value 1
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Type Dword -Value 1
	# Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" -Name "DisableHeuristics" -Type Dword -Value 1
	Write-Host("Done.")
}

function ExplorerStuffs(){
	# General - Hide "People" bar in File Explorer.
	Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "HidePeopleBar" -Type Dword -Value 1
	# Privacy - Disable online content in Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "AllowOnlineTips" -Type Dword -Value 0
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoInternetOpenWith" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoOnlinePrintsWizard" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoPublishingWizard" -Type Dword -Value 1
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoWebServices" -Type Dword -Value 1
	# Privacy - Disable recent documents in Explorer.
	Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Type Dword -Value 1
	Set-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ClearRecentDocsOnExit" -Type Dword -Value 1
	# Privacy - Do not show recently or frequently accessed files in Quick access (Explorer).
	Set-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type Dword -Value 0
	Set-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type Dword -Value 0
	# Security - Do not hide extensions for know file types.
	Set-RegistryValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value '0'  -Type 'Dword'  # Displays file extensions
	Set-RegistryValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'SharingWizardOn' -Value '0' -Type 'Dword' # Disables Sharing Wizard
}

function FirewallHardening(){
	
	# Privacy/Security - Firewall apps and services that may collect user data.
	# Disable default rules.
	netsh advfirewall firewall set rule group="Connect" new enable=no
	netsh advfirewall firewall set rule group="Contact Support" new enable=no
	netsh advfirewall firewall set rule group="Cortana" new enable=no
	netsh advfirewall firewall set rule group="DiagTrack" new enable=no
	netsh advfirewall firewall set rule group="Feedback Hub" new enable=no
	netsh advfirewall firewall set rule group="Microsoft Photos" new enable=no
	netsh advfirewall firewall set rule group="OneNote" new enable=no
	netsh advfirewall firewall set rule group="Remote Assistance" new enable=no
	netsh advfirewall firewall set rule group="Windows Spotlight" new enable=no

	# Delete custom rules in case script has previously run.
	netsh advfirewall firewall delete rule name="block_Connect_in"
	netsh advfirewall firewall delete rule name="block_Connect_out"
	netsh advfirewall firewall delete rule name="block_ContactSupport_in"
	netsh advfirewall firewall delete rule name="block_ContactSupport_out"
	netsh advfirewall firewall delete rule name="block_Cortana_in"
	netsh advfirewall firewall delete rule name="block_Cortana_out"
	netsh advfirewall firewall delete rule name="block_DiagTrack_in"
	netsh advfirewall firewall delete rule name="block_DiagTrack_out"
	netsh advfirewall firewall delete rule name="block_dmwappushservice_in"
	netsh advfirewall firewall delete rule name="block_dmwappushservice_out"
	netsh advfirewall firewall delete rule name="block_FeedbackHub_in"
	netsh advfirewall firewall delete rule name="block_FeedbackHub_out"
	netsh advfirewall firewall delete rule name="block_OneNote_in"
	netsh advfirewall firewall delete rule name="block_OneNote_out"
	netsh advfirewall firewall delete rule name="block_Photos_in"
	netsh advfirewall firewall delete rule name="block_Photos_out"
	netsh advfirewall firewall delete rule name="block_RemoteRegistry_in"
	netsh advfirewall firewall delete rule name="block_RemoteRegistry_out"
	netsh advfirewall firewall delete rule name="block_RetailDemo_in"
	netsh advfirewall firewall delete rule name="block_RetailDemo_out"
	netsh advfirewall firewall delete rule name="block_WMPNetworkSvc_in"
	netsh advfirewall firewall delete rule name="block_WMPNetworkSvc_out"
	netsh advfirewall firewall delete rule name="block_WSearch_in"
	netsh advfirewall firewall delete rule name="block_WSearch_out"


	# Add custom blocking rules.
	netsh advfirewall firewall add rule name="block_Connect_in" dir=in program="%WINDIR%\SystemApps\Microsoft.PPIProjection_cw5n1h2txyewy\Receiver.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_Connect_out" dir=out program="%WINDIR%\SystemApps\Microsoft.PPIProjection_cw5n1h2txyewy\Receiver.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_ContactSupport_in" dir=in program="%WINDIR%\SystemApps\ContactSupport_cw5n1h2txyewy\ContactSupport.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_ContactSupport_out" dir=out program="%WINDIR%\SystemApps\ContactSupport_cw5n1h2txyewy\ContactSupport.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_Cortana_in" dir=in program="%WINDIR%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_Cortana_out" dir=out program="%WINDIR%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_DiagTrack_in" dir=in service="DiagTrack" action=block enable=yes
	netsh advfirewall firewall add rule name="block_DiagTrack_out" dir=out service="DiagTrack" action=block enable=yes
	netsh advfirewall firewall add rule name="block_dmwappushservice_in" dir=in service="dmwappushservice" action=block enable=yes
	netsh advfirewall firewall add rule name="block_dmwappushservice_out" dir=out service="dmwappushservice" action=block enable=yes
	netsh advfirewall firewall add rule name="block_FeedbackHub_in" dir=in program="%ProgramFiles%\WindowsApps\Microsoft.WindowsFeedbackHub_1.1708.2831.0_x64__8wekyb3d8bbwe\PilotshubApp.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_FeedbackHub_out" dir=out program="%ProgramFiles%\WindowsApps\Microsoft.WindowsFeedbackHub_1.1708.2831.0_x64__8wekyb3d8bbwe\PilotshubApp.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_OneNote_in" dir=in program="%ProgramFiles%\WindowsApps\Microsoft.Office.OneNote_17.8625.21151.0_x64__8wekyb3d8bbwe\onenoteim.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_OneNote_out" dir=out program="%ProgramFiles%\WindowsApps\Microsoft.Office.OneNote_17.8625.21151.0_x64__8wekyb3d8bbwe\onenoteim.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_Photos_in" dir=in program="%ProgramFiles%\WindowsApps\Microsoft.Windows.Photos_2017.39091.16340.0_x64__8wekyb3d8bbwe\Microsoft.Photos.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_Photos_out" dir=out program="%ProgramFiles%\WindowsApps\Microsoft.Windows.Photos_2017.39091.16340.0_x64__8wekyb3d8bbwe\Microsoft.Photos.exe" action=block enable=yes
	netsh advfirewall firewall add rule name="block_RemoteRegistry_in" dir=in service="RemoteRegistry" action=block enable=yes
	netsh advfirewall firewall add rule name="block_RemoteRegistry_out" dir=out service="RemoteRegistry" action=block enable=yes
	netsh advfirewall firewall add rule name="block_RetailDemo_in" dir=in service="RetailDemo" action=block enable=yes
	netsh advfirewall firewall add rule name="block_RetailDemo_out" dir=out service="RetailDemo" action=block enable=yes
	netsh advfirewall firewall add rule name="block_WMPNetworkSvc_in" dir=in service="WMPNetworkSvc" action=block enable=yes
	netsh advfirewall firewall add rule name="block_WMPNetworkSvc_out" dir=out service="WMPNetworkSvc" action=block enable=yes
	netsh advfirewall firewall add rule name="block_WSearch_in" dir=in service="WSearch" action=block enable=yes
	netsh advfirewall firewall add rule name="block_WSearch_out" dir=out service="WSearch" action=block enable=yes
}

function SetLoginMOTD{
	$confirm = Read-Host("Set a login MOTD? [y/N]")
	$captiontext = 'UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED.' 
	$text = 'You must have explicit authorized permission to access or configure this device. Unauthorized attempts and actions to access or use this system may result in civil and/or criminal penalties. All activities on this device are logged and monitored.'
	
	if ( ("y", "yes") -contains $confirm){
		Write-Host("$captiontext`n$text")
		$confirm = Read-Host("Use the default value above? [y/N]")
		if ( !(("y", "yes") -contains $confirm)){
			$captiontext = Read-Host("Enter MOTD caption value")
			$text = Read-Host("Enter your MOTD")
		}
		if(!(Test-Path 'Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System')){
			New-Item 'Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
		}
		
		Set-ItemProperty -Path 'Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticecaption' -Value "$captiontext" 
		Set-ItemProperty -Path 'Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticetext' -Value "$text"

		Write-Host("`nLogin MOTD set to:`n$captiontext`n$text")
	}
	else {
		Write-Host("No MOTD set")
	}
}

function DisableSysRestore{
	$confirm = Read-Host("Disable System Restore? [y/N]")
	
	if ( ("y", "yes") -contains $confirm){
		vssadmin delete shadows /all /Quiet |Out-Null
		Write-Host("shadow copies deleted")
        
		Set-RegistryValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore' -Name 'DisableConfig' -Value '1' -Type 'Dword'
		Set-RegistryValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore' -Name 'DisableSR' -Value '1' -Type 'Dword'
		Set-RegistryValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'DisableConfig' -Value '1' -Type 'Dword'
		Set-RegistryValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'DisableSR' -Value '1' -Type 'Dword'
		
		Disable-ScheduledTask -TaskName "\Microsoft\Windows\SystemRestore\SR"
		Write-Host("System Restore Disabled")
	}
}

function SetPasswordPolicy{
	$confirm = Read-Host("Would you like to set a password policy? [Y\n]")
	if ( ("y", "yes", "") -contains $confirm){
		$default = Read-Host("Use default values? (maxpwage:30, minpwage:0, minpwlen:10, lockoutthreshold:10, uniquepw:2) [y\N]")
		if ( ("y", "yes") -contains $default){
			net accounts /maxpwage:30 /minpwage:0 /minpwlen:10 /lockoutthreshold:10 /uniquepw:2 
		}
		else {
			$maxage = Read-Host("Maximum password age")
			$minage = Read-Host("Minimum password age")
			$minlen = Read-Host("Minimum password length")
			$lockouthreshold = Read-Host("Lockout threshold")
			$uniquepw = Read-Host("Unique passwords")

			net accounts /maxpwage:$maxage /minpwage:$minage /minpwlen:$minlen /lockoutthreshold:$lockouthreshold /uniquepw:$uniquepw 
		}
	}
	else {
		Write-Host("No password policy set")
	}
}

function DisableStickyKeys{
	Write-Warning("Disabling Sticky Keys..")
	Set-RegistryValue -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Value '506' -Type 'Dword'
	Write-Host("Done.")
}




# Import required modules
Import-Module ".\Utils.psm1"

# Make sure the script is run with Administrator privileges
if (-Not (IsAdmin))
{
	Write-Warning("The script must be executed with Administrator privileges")
	return
}

# Let the user choose the registry backup destination directory
$regBckpDir = Get-Folder(Get-Location)
if (!$regBckpDir)
{
	Write-Warning("You must select a directory to save the .reg files")
	return
}

# Remove existing backup files
Remove-Item -Path $regBckpDir\*.reg

# Perform a backup of the interested Registry Hives
Write-Host("Backing up registry hives..")
reg export HKLM $regBckpDir\hklm.reg | Out-Null
Write-Host("HKLM saved successfully")
reg export HKCU $regBckpDir\hkcu.reg | Out-Null
Write-Host("HKCU saved successfully")
reg export HKCR $regBckpDir\hkcr.reg | Out-Null
Write-Host("HKCR saved successfully")
Write-Host("Done.")





# Office Hardening
Office_hardening
# Internet Explorer tweaks
IE_hardening
# Edge Hardening tweaks
Edge_hardening


# Flush caches
FlushCaches
# Disable unneeded network connections
DisableNetworks
# Disable unsafe network security protocols and enable TLS 1.2
DisableNetSecProtocols
# Disable IPv6
DisableIPv6


# Disable the SMB Server
DisableSMBServer
# Disable Sharing MappedDrives
DisableSharingMappedDrives
# Disable any Admin Share
DisableAdminShares
# Disable the LLMNR Protocol
DisableLLMNR
# Disable NetBios
DisableNetBios


# Hardening RDP
RDP_hardening


# Remove Unneeded Apps
RemoveApps


# Stop and Disable Unneeded Services
DisableServices


# Disable WiFi-Sense
DisableWiFiSense
# Disable Telemetry
DisableTelemetry
# Disable SmartScreen
EnableSmartScreen
# Disable WebSearch
DisableWebSearch
# Disable DisableBackgroundApps
DisableBackgroundApps
# Disable Feedback
DisableFeedback
# Disable Adv. ID
DisableAdvertisingID
# Disables Sticky keys
DisableStickyKeys





# Windows Firewall hardening
FirewallHardening

# Scheduled Tasks Hardening
DisableScheduledTasks

# Mixed Privacy & Security Features
Misc




# Disable System Restore
DisableSysRestore

# Set login screen MOTD
SetLoginMOTD

# Set UAC Level to High
Write-Warning 'Setting UAC level to High...'
# Set the UAC level to the maximum value
Set-UACLevel 3
Write-Host 'Done.'

# Enable and Configure Windows Defender
if(!$NoAV){
    ConfigureWinDef
}

# Set user password restrictions
SetPasswordPolicy






# Enforce Exploit Mitigation settings (System-level only)
# Set-ProcessMitigation -System -Enable DEP, CFG, BottomUp, SEHOP, TerminateOnError, HighEntropy, ForceRelocateImages
# Enable Memory Integrity -- Core Isolation Win10
#Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -Value 1 -Type Dword


# Restart the device
Write-Warning 'Hardening has finished successfully. Would you like to restart now?'
Set-Variable -Name 'UserResponse' -Value (Read-Host -Prompt '(Y/n)')
Set-ExecutionPolicy restricted
If (($UserResponse -eq 'Y') -or ($UserResponse -eq 'y') -or ($UserResponse -eq "yes")) {
	Restart-Computer -Confirm
}
Else {
	Write-Host 'Not restarting. Please restart device soon.'
}

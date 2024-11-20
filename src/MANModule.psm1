########Author Sathiya

Function Get-ManWebSiteSSLDetail {
	param([Parameter (Mandatory=$true) ] [string]$Name)
	begin {
		################### Variables ####
		$pub = $NULL
		$output = @()
	}
	process {
		$req = [Net.HttpWebRequest]::Create($Name)
		$req.GetResponse() | Out-Null
		$pub = $req.ServicePoint.Certificate.issuer.Split(",")[0]
		$output = [PSCustomObject]@{
			URLHost = $req.host
			'Publisher'= $pub.Replace("'CN=" ,"")
			'CertStartDate' = Get-Date $req.ServicePoint.Certificate.GetEffectiveDateString() -Format "dd/MMM/yyy HH:mm:ss"
			'CertEndDate' = Get-Date $req.ServicePoint.Certificate.GetExpirationDateString() -Format "dd/MMM/yyy HH:mm:ss"
		}
	}
	End{return $output}
}

Function Get-ManSIDName {
	param ([Parameter (Mandatory=$true)][string]$Name)
	begin {}
	process {
		$SID = New-Object System.Security.Principal.SecurityIdentifier($Name)
	}
	end{
		Write-host "Name:" ($SID.Translate([System.Security.Principal.NTAccount])).value -ForegroundColor Green 
	}
}


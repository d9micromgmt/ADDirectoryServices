configuration ADDSPrimaryDC
{
    param 
    (
        [Parameter(Mandatory)]
        [pscredential]$safemodeAdministratorCred,
        [Parameter(Mandatory)]
        [pscredential]$domainCred,
        [Parameter(Mandatory)]
        [pscredential]$DNSDelegationCred,
        [Parameter(Mandatory)]
        [String] $DomainName,
        [Parameter(Mandatory)]
        [String] $RetryCount,
        [Parameter(Mandatory)]
        [String] $RetryIntervalSec
    )

    Import-DSCResource -modulename xActiveDirectory

    Node localhost
    {
        WindowsFeature ADDSInstall
        {
            Ensure = "Present"
            Name = "AD-Domain-Services"
        }
          xWaitForADDomain DscForestWait
        {
            DomainName = $DomainName
            DomainUserCredential = $domainCred
            RetryCount = $RetryCount
            RetryIntervalSec = $RetryIntervalSec
            DependsOn = "[WindowsFeature]ADDSInstall"
        }
        xADDomainController ReplicaDC
        {
            DomainName = $DomainName
            DomainAdministratorCredential = $domainCred
            SafemodeAdministratorPassword = $safemodeAdministratorCred
            DnsDelegationCredential = $DNSDelegationCred
            DependsOn = "[xWaitForADDomain]DscForestWait"
        }
    }
}

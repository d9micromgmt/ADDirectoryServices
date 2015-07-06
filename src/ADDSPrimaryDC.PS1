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
        [String] $DomainName
    )

    Import-DSCResource -modulename xActiveDirectory

    Node localhost
    {
        WindowsFeature ADDSInstall
        {
            Ensure = "Present"
            Name = "AD-Domain-Services"
        }
        xADDomain PrimaryDC
        {
            DomainName = $DomainName
            DomainAdministratorCredential = $domainCred
            SafemodeAdministratorPassword = $safemodeAdministratorCred
            DnsDelegationCredential = $DNSDelegationCred
            DependsOn = "[WindowsFeature]ADDSInstall"
        }
    }
}


function New-IPv4Network {
    <#
    .SYNOPSIS
        Creates a new IPv4Network object.
    .DESCRIPTION
        New-IPv4Network attempts to create a new IPv4 network object from any IP address in the range and a subnet mask
    .EXAMPLE
        New-IPv4Network -IPAddress 192.168.100.222 -SubnetMask 255.255.255.0
    .EXAMPLE
        New-IPv4Network 192.168.100.222 255.255.255.0
    .EXAMPLE
        New-IPv4Network 192.168.100.222/24
    #>

    [CmdletBinding()]
    [OutputType('IPv4Network')]
    param (
        # Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
        [Parameter(Mandatory, Position = 1, ValueFromPipeline)]
        [String]$IPAddress,

        # A subnet mask as an IP address.
        [Parameter(Position = 2)]
        [String]$SubnetMask
    )
    
    begin {
    }
    
    process {
        try {
            $Network = ConvertToNetwork @psboundparameters
        } catch {
            throw $_
        }
        return ([IPv4Network]::New($Network.IPAddress,$Network.SubnetMask))
    }
    
    end {
    }
}

function New-IPv4Address {
    <#
    .SYNOPSIS
        Instantiates an instance of the IPv4Network Class.
    .DESCRIPTION
        Instantiates an instance of the IPv4Network Class.  Returns an object of that class.
        Accepts as parameters either IP address and network in CIDR notation (e.g., "192.168.250.120/24"),
        an IP address and subnet mask, or an IP Address and CIDR subnet mask.
    .EXAMPLE
        New-IPv4Address -IPAddress 192.168.100.222 -SubnetMask 255.255.255.0
    .EXAMPLE
        New-IPv4Address 192.168.100.222/24
    .EXAMPLE
        New-IPv4Address 192.168.100.222 255.255.255.0
    .EXAMPLE
        New-IPv4Address 192.168.100.222 24

    .PARAMETER IPAddress
    An IPv4 address.  (e.g., 192.168.100.222 or 192.168.100.222/24)
    .PARAMETER SubnetMask
    The subnet mask of the network.  (e.g., 255.255.255.0 or 24)
    #>

    [CmdletBinding()]
    [OutputType('IPv4Address')]
    param (
        # Either a literal IP address, a network range expressed as CIDR notation, or an IP address and subnet mask in a string.
        [Parameter(Mandatory, Position = 1, ValueFromPipeline)]
        [String]$IPAddress,

        # A subnet mask as an IP address.
        [Parameter(Position = 2)]
        [String]$SubnetMask
    )
    
    begin {
    }
    
    process {
        try {
            $Network = ConvertToNetwork @psboundparameters
        } catch {
            throw $_
        }
        return ([IPv4Address]::New($Network.IPAddress,$Network.SubnetMask))
    }
    
    end {
    }
}
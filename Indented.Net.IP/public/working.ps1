class IPv4Network {
    [IPAddress]$NetworkAddress
    [UInt32]$NetworkDecimal
    [IPAddress]$BroadcastAddress
    [UInt32]$BroadcastDecimal
    [IPAddress]$Mask
    [Int]$MaskLength
    [String]$MaskHexadecimal
    [String]$CIDRNotation
    [String]$HostRange
    [UInt32]$NumberOfAddresses
    [UInt32]$NumberOfHosts
    [String]$Class
    [Bool]$IsPrivate

    # Constructors:
    # Parameterless Constructor
    IPv4Network() {
    }

    # Constructor with CIDR Notation
    IPv4Network([String]$Network){
        $Temp = Get-NetworkSummary -IPAddress $Network
        $Properties = Get-Member -InputObject $Temp -MemberType NoteProperty
        foreach ($p in $Properties) { 
            $this.($p.Name) = $Temp.$($p.Name)
        }
    }

    # Constructor with IP and Subnet Mask
    IPv4Network([IPAddress]$IPAddress, [IPAddress]$Mask){
        $Temp = Get-NetworkSummary -IPAddress $IPAddress -SubnetMask $Mask
        $Properties = Get-Member -InputObject $Temp -MemberType NoteProperty
        foreach ($p in $Properties) { 
            $this.($p.Name) = $Temp.$($p.Name)
        }
    }

    # Constructor with IP and Subnet Mask as strings
    IPv4Network([String]$IPAddress, [String]$Mask){
        $Temp = Get-NetworkSummary -IPAddress $IPAddress -SubnetMask $Mask
        $Properties = Get-Member -InputObject $Temp -MemberType NoteProperty
        foreach ($p in $Properties) { 
            $this.($p.Name) = $Temp.$($p.Name)
        }
    }
    # Constructor with IP address and mask length
    IPv4Network([IPAddress]$IPAddress, [Int]$MaskLength){
        $Temp = Get-NetworkSummary -IPAddress $IPAddress -SubnetMask (ConvertTo-Mask -MaskLength $MaskLength)
        $Properties = Get-Member -InputObject $Temp -MemberType NoteProperty
        foreach ($p in $Properties) { 
            $this.($p.Name) = $Temp.$($p.Name)
        }
    }

   # Constructor with IP address, as string, and mask length
   IPv4Network([String]$IPAddress, [Int]$MaskLength){
        $Temp = Get-NetworkSummary -IPAddress $IPAddress -SubnetMask (ConvertTo-Mask -MaskLength $MaskLength)
        $Properties = Get-Member -InputObject $Temp -MemberType NoteProperty
        foreach ($p in $Properties) { 
            $this.($p.Name) = $Temp.$($p.Name)
        }
    }

    [Array]NetworkRange() {
        return ,(Get-NetworkRange -IPAddress $this.CIDRNotation)
    }

    # Addition Method
    static [IPv4Network]op_Addition([IPv4Network]$Address, [Int]$Operand) {
        $IP = [IPv4Address]::New($Address.BroadcastAddress,$Address.MaskLength)
        $IP = $IP + [Int]([System.Math]::Pow(2,32 - $IP.Network.MaskLength) * $Operand)
        return [IPv4Network]::New([IPAddress]$IP.IPAddress,[IPAddress]$Address.Mask)
    }
    # Subtraction Method
    static [IPv4Network]op_Subtraction([IPv4Network]$Address, [Int]$Operand) {
        $IP = [IPv4Address]::New($Address.BroadcastAddress,$Address.MaskLength)
        $IP = $IP - [Int]([System.Math]::Pow(2,32 - $IP.Network.MaskLength) * $Operand)
        return [IPv4Network]::New([IPAddress]$IP.IPAddress,[IPAddress]$Address.Mask)
    }
}

class IPv4Address {
    [ValidatePattern('^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$')]
    [IPAddress]$IPAddress
    [IPv4Network]$Network

    # Constructors:
    # Parameterless Constructor
    IPv4Address() {
    }

    # Constructor with CIDR Notation
    IPv4Address([String]$Address) {
        [IPAddress]$this.IPAddress = $Address.split("/")[0]
        $this.Network = [IPv4Network]::New([String]$Address)
    }

    # Constructor with IP and Subnet Mask
    IPv4Address([IPAddress]$IPAddress, [IPAddress]$Mask){
        $this.IPAddress = [IPAddress]$IPAddress
        $this.Network = [IPv4Network]::New([IPAddress]$IPAddress,[IPAddress]$Mask)
    }

    # Constructor with IP and Subnet Mask as strings
    IPv4Address([String]$IPAddress, [String]$Mask){
        $this.IPAddress = [IPAddress]$IPAddress
        $this.Network = [IPv4Network]::New([IPAddress]$IPAddress,[IPAddress]$Mask)
    }
    
    # Constructor with IP Address and Mask Length
    IPv4Address([IPAddress]$IPAddress, [Int]$MaskLength){
        $this.IPAddress = [IPAddress]$IPAddress
        $this.Network = [IPv4Network]::New([IPAddress]$IPAddress,[Int]$MaskLength)
    }

    # Constructor with IP Address, as string, and Mask Length
    IPv4Address([String]$IPAddress, [Int]$MaskLength){
        $this.IPAddress = [IPAddress]$IPAddress
        $this.Network = [IPv4Network]::New([IPAddress]$IPAddress,[Int]$MaskLength)
    }

    # Addition Method
    static [IPv4Address]op_Addition([IPv4Address]$Address, [Int]$Operand) {
        [IPAddress]$NewAddress = ConvertTo-DottedDecimalIP -IPAddress ((ConvertTo-DecimalIP -IPAddress $Address.IPAddress) + $Operand)
        return [IPv4Address]::New([IPAddress]$NewAddress,[Int]$Address.Network.MaskLength)
    }

    # Subtraction Method
    static [IPv4Address]op_Subtraction([IPv4Address]$Address, [Int]$Operand) {
        [IPAddress]$NewAddress = ConvertTo-DottedDecimalIP -IPAddress ((ConvertTo-DecimalIP -IPAddress $Address.IPAddress) - $Operand)
        return [IPv4Address]::New([IPAddress]$NewAddress,[Int]$Address.Network.MaskLength)
    }
}

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
        
    )
    
    begin {
    }
    
    process {
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
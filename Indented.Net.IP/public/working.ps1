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
        $temp = Get-NetworkSummary -IPAddress $Network
        $this.NetworkAddress = $temp.NetworkAddress
        $this.NetworkDecimal = $temp.NetworkDecimal
        $this.BroadcastAddress = $temp.BroadcastAddress 
        $this.BroadcastDecimal = $temp.BroadcastDecimal 
        $this.Mask = $temp.Mask
        $this.MaskLength = $temp.MaskLength 
        $this.MaskHexadecimal = $temp.MaskHexadecimal
        $this.CIDRNotation = $temp.CIDRNotation
        $this.HostRange = $temp.HostRange
        $this.NumberOfAddresses = $temp.NumberOfAddresses
        $this.NumberOfHosts = $temp.NumberOfHosts 
        $this.Class = $temp.Class
        $this.IsPrivate = $temp.IsPrivate
    }

    # Constructor with IP and Subnet Mask
    IPv4Network([IPAddress]$IPAddress, [IPAddress]$Mask){
        $temp = Get-NetworkSummary -IPAddress $IPAddress -SubnetMask $Mask
        $this.NetworkAddress = $temp.NetworkAddress
        $this.NetworkDecimal = $temp.NetworkDecimal
        $this.BroadcastAddress = $temp.BroadcastAddress 
        $this.BroadcastDecimal = $temp.BroadcastDecimal 
        $this.Mask = $temp.Mask
        $this.MaskLength = $temp.MaskLength 
        $this.MaskHexadecimal = $temp.MaskHexadecimal
        $this.CIDRNotation = $temp.CIDRNotation
        $this.HostRange = $temp.HostRange
        $this.NumberOfAddresses = $temp.NumberOfAddresses
        $this.NumberOfHosts = $temp.NumberOfHosts 
        $this.Class = $temp.Class
        $this.IsPrivate = $temp.IsPrivate
    }

    # Constructor with IP and Subnet Mask as strings
    IPv4Network([String]$IPAddress, [String]$Mask){
        $temp = Get-NetworkSummary -IPAddress $IPAddress -SubnetMask $Mask
        $this.NetworkAddress = $temp.NetworkAddress
        $this.NetworkDecimal = $temp.NetworkDecimal
        $this.BroadcastAddress = $temp.BroadcastAddress 
        $this.BroadcastDecimal = $temp.BroadcastDecimal 
        $this.Mask = $temp.Mask
        $this.MaskLength = $temp.MaskLength 
        $this.MaskHexadecimal = $temp.MaskHexadecimal
        $this.CIDRNotation = $temp.CIDRNotation
        $this.HostRange = $temp.HostRange
        $this.NumberOfAddresses = $temp.NumberOfAddresses
        $this.NumberOfHosts = $temp.NumberOfHosts 
        $this.Class = $temp.Class
        $this.IsPrivate = $temp.IsPrivate
    }
    # Constructor with IP address and mask length
    IPv4Network([IPAddress]$IPAddress, [Int]$MaskLength){
        $temp = Get-NetworkSummary -IPAddress $IPAddress -SubnetMask (ConvertTo-Mask -MaskLength $MaskLength)
        $this.NetworkAddress = $temp.NetworkAddress
        $this.NetworkDecimal = $temp.NetworkDecimal
        $this.BroadcastAddress = $temp.BroadcastAddress 
        $this.BroadcastDecimal = $temp.BroadcastDecimal 
        $this.Mask = $temp.Mask
        $this.MaskLength = $temp.MaskLength 
        $this.MaskHexadecimal = $temp.MaskHexadecimal
        $this.CIDRNotation = $temp.CIDRNotation
        $this.HostRange = $temp.HostRange
        $this.NumberOfAddresses = $temp.NumberOfAddresses
        $this.NumberOfHosts = $temp.NumberOfHosts 
        $this.Class = $temp.Class
        $this.IsPrivate = $temp.IsPrivate
    }

   # Constructor with IP address, as string, and mask length
   IPv4Network([String]$IPAddress, [Int]$MaskLength){
    $temp = Get-NetworkSummary -IPAddress $IPAddress -SubnetMask (ConvertTo-Mask -MaskLength $MaskLength)
    $this.NetworkAddress = $temp.NetworkAddress
    $this.NetworkDecimal = $temp.NetworkDecimal
    $this.BroadcastAddress = $temp.BroadcastAddress 
    $this.BroadcastDecimal = $temp.BroadcastDecimal 
    $this.Mask = $temp.Mask
    $this.MaskLength = $temp.MaskLength 
    $this.MaskHexadecimal = $temp.MaskHexadecimal
    $this.CIDRNotation = $temp.CIDRNotation
    $this.HostRange = $temp.HostRange
    $this.NumberOfAddresses = $temp.NumberOfAddresses
    $this.NumberOfHosts = $temp.NumberOfHosts 
    $this.Class = $temp.Class
    $this.IsPrivate = $temp.IsPrivate
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


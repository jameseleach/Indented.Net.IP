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
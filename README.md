# Indented.Net.IP
Forked from https://github.com/indented-automation/Indented.Net.IP

### This is a work in progress, extending on Indented.Net.IP, by the use of PowerShell Classes
Example of additional functionality:
```
PS D:\> $Network = New-IPv4Network 24.173.29.77/29 
PS D:\> $Network | Get-Member

   TypeName: IPv4Network

Name              MemberType Definition
----              ---------- ----------
Equals            Method     bool Equals(System.Object obj)
GetHashCode       Method     int GetHashCode()
GetType           Method     type GetType()
NetworkRange      Method     array NetworkRange()
ToString          Method     string ToString()
BroadcastAddress  Property   ipaddress BroadcastAddress {get;set;}
BroadcastDecimal  Property   uint32 BroadcastDecimal {get;set;}
CIDRNotation      Property   string CIDRNotation {get;set;}
Class             Property   string Class {get;set;}
HostRange         Property   string HostRange {get;set;}
IsPrivate         Property   bool IsPrivate {get;set;}
Mask              Property   ipaddress Mask {get;set;}
MaskHexadecimal   Property   string MaskHexadecimal {get;set;}
MaskLength        Property   int MaskLength {get;set;}
NetworkAddress    Property   ipaddress NetworkAddress {get;set;}
NetworkDecimal    Property   uint32 NetworkDecimal {get;set;}
NumberOfAddresses Property   uint32 NumberOfAddresses {get;set;}  
NumberOfHosts     Property   uint32 NumberOfHosts {get;set;}

PS D:\> ($Network + 1).NetworkAddress.IPAddressToString
24.173.29.80

PS D:\> $Network.NetworkRange().IPAddressToString
24.173.29.73
24.173.29.74
24.173.29.75
24.173.29.76
24.173.29.77
24.173.29.78

PS D:\> $Address = New-IPv4Address 192.198.100.222 255.255.255.0                
PS D:\> $Address

IPAddress       Network    
---------       -------
192.198.100.222 IPv4Network
```

### Original README.md follows

[![Build status](https://ci.appveyor.com/api/projects/status/u09nudqyvm1nbp6k?svg=true)](https://ci.appveyor.com/project/indented-automation/indented-net-ip)

A collection of commands written to perform IPv4 subnet math.

## Installation

```powershell
Install-Module Indented.Net.IP
```

## Commands

| Name | Synopsis |
| --- | --- |
| ConvertFrom-HexIP | Converts a hexadecimal IP address into a dotted decimal string. |
| ConvertTo-BinaryIP | Converts a Decimal IP address into a binary format. |
| ConvertTo-DecimalIP | Converts a Decimal IP address into a 32-bit unsigned integer. |
| ConvertTo-DottedDecimalIP | Converts either an unsigned 32-bit integer or a dotted binary string to an IP Address. |
| ConvertTo-HexIP | Convert a dotted decimal IP address into a hexadecimal string. |
| ConvertTo-Mask | Convert a mask length to a dotted-decimal subnet mask. |
| ConvertTo-MaskLength | Convert a dotted-decimal subnet mask to a mask length. |
| ConvertTo-Subnet | Convert a start and end IP address to the closest matching subnet. |
| Get-BroadcastAddress | Get the broadcast address for a network range. |
| Get-NetworkAddress | Get the network address for a network range. |
| Get-NetworkRange | Get a list of IP addresses within the specified network. |
| Get-NetworkSummary | Generates a summary describing several properties of a network range. |
| Get-Subnet | Get a list of subnets of a given size within a defined supernet. |
| Resolve-IPAddress | Resolves an IP address expression using wildcard expressions to individual IP addresses. |
| Test-SubnetMember | Tests an IP address to determine if it falls within IP address range. |

# UpdateMoodleInformation

## SYNOPSIS
Updates Moodle user information.

## SYNTAX

### DefParamSet (Default)
```
UpdateMoodleInformation -EmployeeId <String> [-FirstName <String>] [-LastName <String>] [-Email <String>] [-IdNumber <String>] [-TimeZone <String>] [-UserName <String>] [-Password <String>] [-Description <String>] [-City <String>] [-Country <String>] [-MiddleName <String>] [-Suspended <String>] -URI <String> -ApiToken <String> [<CommonParameters>]
```

### EmailParamSet
```
UpdateMoodleInformation -EmployeeEmail <String> [-FirstName <String>] [-LastName <String>] [-Email <String>] [-IdNumber <String>] [-TimeZone <String>] [-UserName <String>] [-Password <String>] [-Description <String>] [-City <String>] [-Country <String>] [-MiddleName <String>] [-Suspended <String>] -URI <String> -ApiToken <String> [<CommonParameters>]
```

## DESCRIPTION
This Script is utilized as part of the UMS (User Management Service) to update attributes in Moodle.
It has the ability to update attributes based on email address or a Login ID.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
PS C:\\\>
```powershell
.\UpdateMoodleInformation.ps1 -EmployeeEmail donn.jacobs@hello.com -LastName Smith -Email donn.smith@hello.com -ApiToken opezeodzicdaiueuluujwsygqtaoej -URI https://test11.ethinkeducation.com/donnrocks_test
```

This will find the user donn.jacobs@hello.com and update the last name to "Smtih" and the email address to "donn.smith@hello.com".
Will use the URI https://test11.ethinkeducation.com/donnrocks_test and the Token of opezeodzicdaiueuluujwsygqtaoej

### -------------------------- EXAMPLE 2 --------------------------
PS C:\\\>
```powershell
.\UpdateMoodleInformation.ps1 -EmployeeEmail donn.jacobs@hello.com -City "Fond du Lac" -ApiToken opezeodzicdaiueuluujwsygqtaoej -URI https://test11.ethinkeducation.com/donnrocks_test
```

This will find the user "donn.jacobs@hello.com" and update the City to "Fond du Lac"
Note: If there are spaces in your values, enclose the string within quotes.
Will use the URI https://test11.ethinkeducation.com/donnrocks_test and the Token of opezeodzicdaiueuluujwsygqtaoej

### -------------------------- EXAMPLE 3 --------------------------
PS C:\\\>
```powershell
.\UpdateMoodleInformation.ps1 -EmployeeEmail donn.jacobs@hello.com -City "Fond du Lac" -ApiToken opezeodzicdaiueuluujwsygqtaoej -URI https://test11.ethinkeducation.com/donnrocks_test
```

This will update the user "donn.jacobs@hello.com" using a specific API Token and going to a specific URI.
Will use the URI https://test11.ethinkeducation.com/donnrocks_test and the Token of opezeodzicdaiueuluujwsygqtaoej

### -------------------------- EXAMPLE 4 --------------------------
PS C:\\\>
```powershell
.\UpdateMoodleInformation.ps1 -EmployeeEmail donn.jacobs@hello.com -City "Fond du Lac" -ApiToken opezeodzicdaiueuluujwsygqtaoej -URI https://test11.ethinkeducation.com/donnrocks_test -Debug -Verbose
```

This will find the user "donn.jacobs@hello.com" and update the last name to "Smtih".
Will show messages about what the script is doing and steps the program takes.
Will prompt for debug options throught the script.
Will use the URI https://test11.ethinkeducation.com/donnrocks_test and the Token of opezeodzicdaiueuluujwsygqtaoej

## PARAMETERS

### EmployeeId
The username of the user to update

```yaml
Type: String
Parameter Sets: DefParamSet
Aliases: 

Required: true
Position: named
Default Value: 
Pipeline Input: True (ByPropertyName, ByValue)
```

### FirstName
This will be the new first name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### LastName
This will be the new last name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### Email
This will be the new email address of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### IdNumber
This will be the new ID Number of the user.
Caution, changing this could be dangerous. Know what you want to do before modifying this value.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### TimeZone
This will be the new time zone of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### UserName
This will be the new user name/Login Id of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### Password
This will be the new password of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### Description
This will be the new description of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### City
This will be the new city of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### Country
This will be the new country of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### MiddleName
This will be the new MiddleName name of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### Suspended
This will determine if the user can login or not.
0 for Enabled
1 for Disabled / Suspended

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: false
Position: named
Default Value: 
Pipeline Input: false
```

### URI
This is the URI you want to use to connect to.
Make sure you start with the "https://" before the name
You do NOT need to finish with a "/" also, the script assumes that you are just giving the name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: true
Position: named
Default Value: 
Pipeline Input: false
```

### ApiToken
This is the API Token for the environment.

```yaml
Type: String
Parameter Sets: (All)
Aliases: API , Token

Required: true
Position: named
Default Value: 
Pipeline Input: false
```

### EmployeeEmail
The current email address of the user to update.
This is not what you are going to update the email address to.

```yaml
Type: String
Parameter Sets: EmailParamSet
Aliases: 

Required: true
Position: named
Default Value: 
Pipeline Input: True (ByPropertyName, ByValue)
```

### \<CommonParameters\>
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Created by Donald Jacobs
Created on 2017-08-17

If you get tired of putting the API Token and URI in each time, and this script will stay pretty much the same, you can change the default values in the Param section to your defaults, but then change mandatory to false.

## RELATED LINKS

[Online version:](http://www.hbs.net)


*Generated by: PowerShell HelpWriter 2017 v2.1.36*


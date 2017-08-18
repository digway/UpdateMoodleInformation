<#
.Synopsis
    Updates Moodle user information.
.Description
    This Script is utilized as part of the UMS (User Management Service) to update attributes in Moodle.
    It has the ability to update attributes based on email address or a Login ID.
.Example
    .\UpdateMoodleInformation.ps1 -EmployeeEmail donn.jacobs@hello.com -LastName Smith -Email donn.smith@hello.com -ApiToken opezeodzicdaiueuluujwsygqtaoej -URI https://test11.ethinkeducation.com/donnrocks_test
    This will find the user donn.jacobs@hello.com and update the last name to "Smtih" and the email address to "donn.smith@hello.com".
    Will use the URI https://test11.ethinkeducation.com/donnrocks_test and the Token of opezeodzicdaiueuluujwsygqtaoej
.Example
    .\UpdateMoodleInformation.ps1 -EmployeeEmail donn.jacobs@hello.com -City "Fond du Lac" -ApiToken opezeodzicdaiueuluujwsygqtaoej -URI https://test11.ethinkeducation.com/donnrocks_test
    This will find the user "donn.jacobs@hello.com" and update the City to "Fond du Lac"
    Note: If there are spaces in your values, enclose the string within quotes.
    Will use the URI https://test11.ethinkeducation.com/donnrocks_test and the Token of opezeodzicdaiueuluujwsygqtaoej
.Example
    .\UpdateMoodleInformation.ps1 -EmployeeEmail donn.jacobs@hello.com -City "Fond du Lac" -ApiToken opezeodzicdaiueuluujwsygqtaoej -URI https://test11.ethinkeducation.com/donnrocks_test
    This will update the user "donn.jacobs@hello.com" using a specific API Token and going to a specific URI.
    Will use the URI https://test11.ethinkeducation.com/donnrocks_test and the Token of opezeodzicdaiueuluujwsygqtaoej
.Example
    .\UpdateMoodleInformation.ps1 -EmployeeEmail donn.jacobs@hello.com -City "Fond du Lac" -ApiToken opezeodzicdaiueuluujwsygqtaoej -URI https://test11.ethinkeducation.com/donnrocks_test -Debug -Verbose
    This will find the user "donn.jacobs@hello.com" and update the last name to "Smtih".
    Will show messages about what the script is doing and steps the program takes.
    Will prompt for debug options throught the script.
    Will use the URI https://test11.ethinkeducation.com/donnrocks_test and the Token of opezeodzicdaiueuluujwsygqtaoej
.Notes
    Created by djacobs@hbs.net
    Created on 2017-08-17

    If you get tired of putting the API Token and URI in each time, and this script will stay pretty much the same, you can change the default values in the Param section to your defaults, but then change mandatory to false.
.Link
    http://www.hbs.net
#>
[CmdletBinding(DefaultParameterSetName = 'DefParamSet',
               SupportsShouldProcess = $true,
               PositionalBinding = $false,
               ConfirmImpact = 'Medium')]
Param (
    # The username of the user to update
    [Parameter(Mandatory = $true,
               ValueFromPipeline = $true,
               ValueFromPipelineByPropertyName = $true,
               ValueFromRemainingArguments = $false,
               ParameterSetName = 'DefParamSet')]
    [ValidateNotNullOrEmpty()]
    [string]$EmployeeId,

    # The current email address of the user to update.
    # This is not what you are going to update the email address to.
    [Parameter(Mandatory = $true,
               ValueFromPipeline = $true,
               ValueFromPipelineByPropertyName = $true,
               ValueFromRemainingArguments = $false,
               ParameterSetName = 'EmailParamSet')]
    [ValidateNotNullOrEmpty()]
    [string]$EmployeeEmail,

    # This will be the new first name of the user.
    [string]$FirstName,

    # This will be the new last name of the user.
    [string]$LastName,

    # This will be the new email address of the user.
    [string]$Email,

    # This will be the new ID Number of the user.
    # Caution, changing this could be dangerous. Know what you want to do before modifying this value.
    [string]$IdNumber,

    # This will be the new time zone of the user.
    [string]$TimeZone,

    # This will be the new user name/Login Id of the user.
    [string]$UserName,

    # This will be the new password of the user.
    [string]$Password,

    # This will be the new description of the user.
    [string]$Description,

    # This will be the new city of the user.
    [string]$City,

    # This will be the new country of the user.
    [string]$Country,

    # This will be the new MiddleName name of the user.
    [string]$MiddleName,

    # This will determine if the user can login or not.
    # 0 for Enabled
    # 1 for Disabled / Suspended
    [ValidateSet("0", "1")]
    [string]$Suspended,

    # This is the URI you want to use to connect to.
    # Make sure you start with the "https://" before the name
    # You do NOT need to finish with a "/" also, the script assumes that you are just giving the name.
    [Parameter(Mandatory = $true)]
    [string]$URI,

    # This is the API Token for the environment.
    [Parameter(Mandatory = $true)]
    [Alias("API", "Token")]
    [string]$ApiToken
)
Begin {
    Function Get-IgCurrentLineNumber {
        # Simply Displays the Line number within the script.
        [string]$line = $MyInvocation.ScriptLineNumber
        $line.PadLeft(4, '0')
    }

    #region Clean up URI if needed
    if ($URI.Substring($URI.Length - 1) -eq '/') {
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] The URI has a trailing slash, I'll remove it."
        $URI = $URI.Substring(0, $URI.Length - 1)
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] After cleaning the new URI is '$URI'."
    } else {
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] The URI '$URI' did not have a trailing slash. Awesome."
    }
    #endregion
}
Process {
    #region Get the User ID
    if ($PSCmdlet.ParameterSetName -eq 'DefParamSet') {
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Looking up the user by Login ID '$EmployeeId'."
        $lookUpId = $EmployeeId
        $UserResource = $URI +
        "/webservice/rest/server.php?wstoken=" +
        $ApiToken +
        "&wsfunction=core_user_get_users&moodlewsrestformat=json&criteria[0][key]=username&criteria[0][value]=" +
        $EmployeeId
    } else {
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Looking up the user by EmailAddress '$EmployeeEmail'."
        $lookUpId = $EmployeeEmail
        $UserResource = $URI +
        "/webservice/rest/server.php?wstoken=" +
        $ApiToken +
        "&wsfunction=core_user_get_users&moodlewsrestformat=json&criteria[0][key]=email&criteria[0][value]=" +
        $EmployeeEmail
    }

    Write-Debug -Message 'Going to use this URI search string of "$UserResource"'

    # Let's try to get the user from THE CLOUD (cough cough)
    Try {
        $UserReturn = Invoke-RestMethod -Uri $UserResource -ErrorAction Stop
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Successfully called the Rest API."
    } Catch {
        Write-Error -Message "[Line: $(Get-IgCurrentLineNumber)] Cannot call the Rest API because $_" -ErrorAction Stop
    }

    Write-Debug -Message 'Return info from Rest API in variable "$UserReturn"'

    # Determine how many users were returned from the query.
    switch ($UserReturn.users.Count) {
        1 {
            # This is a good thing.
            Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Only found 1 user. Continue."
        }
        Default {
            # This is any other answer other than 1.
            Write-Error -Message "[Line: $(Get-IgCurrentLineNumber)] When Looking for '$lookUpId' we returned '$($UserReturn.users.Count)' objects. Cannot continue." -ErrorAction Stop
        }
    }

    $UpdateUserID = $UserReturn.users.id
    Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] We found this User ID: '$UpdateUserID' with email address of $($UserReturn.users.email)"
    Write-Debug -Message 'We found variables: "$UserReturn", "$UpdateUserID"'
    #endregion

    #region Time to update user
    # Let's assume we didn't get any switches.
    $YesIHadSwitches = $false

    # This is the start of the URI, we'll add stuff to it as we find.
    $updateUri = "$($URI)/webservice/rest/server.php?wstoken=$($ApiToken)&wsfunction=core_user_update_users&moodlewsrestformat=json&users[0][id]=$($UpdateUserID)"

    if ($FirstName) {
        $fn = $FirstName.Trim()
        $fn = $fn -replace ' ', '%20'
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding UserName of '$fn'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][firstname]=$fn"
    }

    if ($UserName) {
        $un = $UserName.Trim()
        if ($un -match ' ') {
            Write-Error -Message "The UserName of '$un' contains spaces. Cannot continue." -ErrorAction Stop
        }
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding UserName of '$un'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][username]=$un"
    }

    if ($LastName) {
        $ln = $LastName.Trim()
        $ln = $ln -replace ' ', '%20'
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding LastName of '$ln'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][lastname]=$ln"
    }

    if ($Email) {
        $em = ($Email.ToLower()).Trim()
        if ($em -match ' ') {
            Write-Error -Message "The Email Address  of '$em' contains spaces. Cannot continue." -ErrorAction Stop
        }
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding Email of '$em'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][email]=$em"
    }

    if ($IdNumber) {
        $id = $IdNumber.Trim()
        if ($id -match ' ') {
            Write-Error -Message "The ID Number  of '$id' contains spaces. Cannot continue." -ErrorAction Stop
        }
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding IdNumber of '$id'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][idnumber]=$($id)"
    }

    if ($TimeZone) {
        $tz = $TimeZone.Trim()
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding TimeZone of '$tz'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][timezone]=$tz"
    }

    if ($Password) {
        $pw = $Password.Trim()
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding Password of '$pw'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][password]=$pw"
    }

    if ($Description) {
        $desc = $Description.Trim()
        $desc = $desc -replace ' ', '%20'
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding Description of '$desc'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][description]=$desc"
    }

    if ($City) {
        $ci = $City.Trim()
        $ci = $ci -replace ' ', '%20'
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding City of '$ci'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][city]=$ci"
    }

    if ($Country) {
        $co = $Country.Trim()
        $co = $co -replace ' ', '%20'
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding Country of '$co'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][country]=$co"
    }

    if ($MiddleName) {
        $mn = $MiddleName.Trim()
        $mn = $mn -replace ' ', '%20'
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding MiddleName of '$mn'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][middlename]=$mn"
    }

    if ($Suspended) {
        $sus = $Suspended.Trim()
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Adding Suspended of '$sus'."
        $YesIHadSwitches = $true
        $updateUri += "&users[0][suspended]=$sus"
    }

    if ($YesIHadSwitches) {
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Yes, there were switches, carry on."
    } else {
        Write-Warning -Message "[Line: $(Get-IgCurrentLineNumber)] No switches were used, nothing to do but stop."
        Exit
    }

    Write-Debug -Message 'Going to call this URI "$updateUri" and update the user.'

    # This is the call to update the user.
    Try {
        $UpdateReturn = Invoke-RestMethod -Uri $updateUri -ErrorAction Stop
        Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Successfully called the Rest API."
    } Catch {
        Write-Warning -Message "[Line: $(Get-IgCurrentLineNumber)] Could NOT call the API because $_"
    }
    #endregion

    #region Check if anything went wrong.
    if ($UpdateReturn.PSObject.Properties['exception']) {
        Write-Warning -Message "[Line: $(Get-IgCurrentLineNumber)] Error updating '$lookUpId' because $($UpdateReturn.exception)"
    } else {
        Write-Host -Object "[Line: $(Get-IgCurrentLineNumber)] Successfully updated '$lookUpId'." -ForegroundColor Green
    }
    #endregion
}
End {
    Write-Debug -Message 'Program Stopping. Last Chance to check variables.'
    Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] Program Complete."
}
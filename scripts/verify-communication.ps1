[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z0-9]+(?:-[a-z0-9]+)*$')]
    [string]$Slug,

    [string]$SiteUrl = 'http://localhost:8080'
)

$sql = "SELECT title, slug, status FROM posts WHERE slug = '$Slug';"
$databaseResult = $sql | docker compose exec --no-TTY mysql sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" mysql --batch --skip-column-names -u"$MYSQL_USER" "$MYSQL_DATABASE"'
if ($LASTEXITCODE -ne 0) {
    throw 'No fue posible consultar MySQL desde el contenedor mysql.'
}
if (-not $databaseResult) {
    throw "No se encontró el slug '$Slug' en la tabla posts de MySQL."
}

$pageUrl = '{0}/{1}/' -f $SiteUrl.TrimEnd('/'), $Slug
$response = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing
if ($response.StatusCode -ne 200 -or $response.Content.IndexOf($Slug, [System.StringComparison]::OrdinalIgnoreCase) -lt 0) {
    throw "Ghost no devolvió la publicación '$Slug' en $pageUrl."
}

Write-Output "Registro en MySQL: $databaseResult"
Write-Output "Página publicada: HTTP $($response.StatusCode) $pageUrl"

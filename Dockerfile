FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]  
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); \
                choco install dotnetcore-runtime --version 2.1.10 -y --no-progress; \
                choco install aspnetcore-runtimepackagestore --version 2.1.10 -y --no-progress
WORKDIR /app  
COPY artifacts .  

ENV ASPNETCORE_URLS=http://+:80  
ENV DOTNET_RUNNING_IN_CONTAINER=true  
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
ENV NUGET_XMLDOC_MODE=skip    
EXPOSE 80
ENTRYPOINT [ "dotnet", "/app/bin/Release/netcoreapp2.1/AnandCoreTestS.dll" ]
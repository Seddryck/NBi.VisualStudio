# NBi.VisualStudio
This project is facilitating the usage of NBi within Visual Studio.

![Still maintained](https://img.shields.io/maintenance/yes/2017.svg)
![nuget](https://img.shields.io/nuget/v/NBi.VisualStudio.svg) 
![nuget pre](https://img.shields.io/nuget/vpre/NBi.VisualStudio.svg)

Usage
=====

1. Create a new Visual Studio project of type "Class Library (.NET Framework)"
1. Go to the "Package Manager Console" 
1. Run the following command: ``` Install-Package NBi.VisualStudio```

That's it!
If you press ```F5``` (or Start/debug) for this project, Visual Studio will start NUnit GUI and automatically link to the test-suite available in the same project. It will also automatically run the selected tests.


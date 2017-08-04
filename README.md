# Auto_Proxifier_iP_Change
Automate Proxyfier IP changes (profile creator &amp; changer) [SourceCode]

User: @GeezNotThatGuy
I had some trouble with a browser based bot using proxys. So i got the tip from @SPPChristian to use Proxyfier which worked great.
So in order to work with my bot, i needed somekind of automization that changes the proxys in Proxyfier when it is needed. 
So I coded a little script that:
1. receives the IP, Port, Username, Password via the commandline parameter
2. creates an profile for Proxyfier (IP handling is managed by profiles)
3. starts/loads Proxyfier with that profile

How to use:
Put the programm in the Proxyfier folder (where you can find the Proxifier.exe). 
`Run the Programm with the following commandline params: 1 <proxyip> <proxyport> <proxyusename> <proxypass>`

Thats it. Now Proxyfier automatically loads the fresh created profile we just created.

I give you here the sourcecode, so that you can tweak, fix and optimize the programm after your likings.

And yeah, it´s AutoIt code... I had to change the at-symbol to (at) because it triggers the "BHW New User not allowed to post Emailaddresses" spam protection.

It´s very basic, but hopefully It saves someone out there some time and headaches :)

In case you wonder where to get Proxyfier. Download the 30 Day trail from the official website or search for it here on BHW. I know that a free version is offered here somewhere.

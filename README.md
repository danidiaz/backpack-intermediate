This cabal project is an example of how Backpack module signatures are carried
implicitly by intermediate "indefinite" packages which depend on the package
which provides the signature, but without filling it.

- `core` is the package with the signature.

- `intermediate` depends on `core` but it doesn't fill its signature.

- `final` depends on `intermediate` and fills its outstanding signature with an
  implementation.

Example compilation on Windows:

    PS C:\Users\someuser\hs\backpack-intermediate> cabal clean
    PS C:\Users\someuser\hs\backpack-intermediate> cabal build all
    Resolving dependencies...
    Build profile: -w ghc-9.0.1 -O1
    In order, the following will be built (use -v for more details):
     - core-0.1.0.0 (lib) (first run)
     - final-0.1.0.0 (lib:impl-lib) (first run)
     - intermediate-0.1.0.0 (lib) (first run)
     - core-0.1.0.0 (lib with Core.SomeSig=final-0.1.0.0-inplace-impl-lib:Core.SomeImpl) (first run)
     - intermediate-0.1.0.0 (lib with Core.SomeSig=final-0.1.0.0-inplace-impl-lib:Core.SomeImpl) (first run)
     - final-0.1.0.0 (exe:final) (first run)
    Configuring library for core-0.1.0.0..
    Configuring library 'impl-lib' for final-0.1.0.0..
    Preprocessing library 'impl-lib' for final-0.1.0.0..
    Building library 'impl-lib' for final-0.1.0.0..
    Preprocessing library for core-0.1.0.0..
    Building library instantiated with Core.SomeSig = <Core.SomeSig>
    for core-0.1.0.0..
    [1 of 1] Compiling Core.SomeImpl    ( lib\Core\SomeImpl.hs, C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\final-0.1.0.0\l\impl-lib\build\impl-lib\Core\SomeImpl.o )
    [1 of 2] Compiling Core.SomeSig[sig] ( lib\Core\SomeSig.hsig, nothing )
    [2 of 2] Compiling Core             ( lib\Core.hs, nothing )
    Configuring library for intermediate-0.1.0.0..
    Configuring library instantiated with
      Core.SomeSig = final-0.1.0.0-inplace-impl-lib:Core.SomeImpl
    for core-0.1.0.0..
    Preprocessing library for intermediate-0.1.0.0..
    Building library instantiated with Core.SomeSig = <Core.SomeSig>
    for intermediate-0.1.0.0..
    [1 of 2] Compiling Core.SomeSig[sig] ( C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\intermediate-0.1.0.0\build\autogen\Core\SomeSig.hsig, nothing )
    [2 of 2] Compiling Intermediate     ( lib\Intermediate.hs, nothing )
    Preprocessing library for core-0.1.0.0..
    Building library instantiated with
      Core.SomeSig = final-0.1.0.0-inplace-impl-lib:Core.SomeImpl
    for core-0.1.0.0..
    [1 of 2] Compiling Core.SomeSig[sig] ( lib\Core\SomeSig.hsig, C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\core-0.1.0.0\core-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\build\core-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\Core\SomeSig.o )
    [2 of 2] Compiling Core             ( lib\Core.hs, C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\core-0.1.0.0\core-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\build\core-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\Core.o )
    Configuring library instantiated with
      Core.SomeSig = final-0.1.0.0-inplace-impl-lib:Core.SomeImpl
    for intermediate-0.1.0.0..
    Preprocessing library for intermediate-0.1.0.0..
    Building library instantiated with
      Core.SomeSig = final-0.1.0.0-inplace-impl-lib:Core.SomeImpl
    for intermediate-0.1.0.0..
    [1 of 2] Compiling Core.SomeSig[sig] ( C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\intermediate-0.1.0.0\intermediate-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\build\intermediate-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\autogen\Core\SomeSig.hsig, C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\intermediate-0.1.0.0\intermediate-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\build\intermediate-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\Core\SomeSig.o )
    [2 of 2] Compiling Intermediate     ( lib\Intermediate.hs, C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\intermediate-0.1.0.0\intermediate-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\build\intermediate-0.1.0.0-inplace+Eus3r8iu6ksDpNBLnxENGw\Intermediate.o )
    Configuring executable 'final' for final-0.1.0.0..
    Preprocessing executable 'final' for final-0.1.0.0..
    Building executable 'final' for final-0.1.0.0..
    [1 of 1] Compiling Main             ( Main.hs, C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\final-0.1.0.0\x\final\build\final\final-tmp\Main.o )
    Linking C:\Users\someuser\hs\backpack-intermediate\dist-newstyle\build\x86_64-windows\ghc-9.0.1\final-0.1.0.0\x\final\build\final\final.exe ...

Example execution:

    PS C:\Users\someuser\hs\backpack-intermediate> cabal run final
    Up to date
    ****** 5 plus bar

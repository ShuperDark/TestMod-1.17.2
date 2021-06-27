#include "substrate.h"
#include <string>
#include <cstdio>
#include <chrono>
#include <memory>
#include <vector>
#include <mach-o/dyld.h>
#include <stdint.h>

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

static uintptr_t** VTDirt;

static uint32_t (*_DirtBlock$getColor)(uintptr_t*, uintptr_t const&);
static uint32_t DirtBlock$getColor(uintptr_t* self, uintptr_t const& block) {

	return 0x00FF00FF;
}

static uintptr_t* (*_GuiMessage$GuiMessage)(uintptr_t*, std::string const&, std::string const&, std::string const&, float, bool);
static uintptr_t* GuiMessage$GuiMessage(uintptr_t* self, std::string const& str1, std::string const& str2, std::string const& str3, float f1, bool b1) {

	return _GuiMessage$GuiMessage(self, str1, "HACKER", "HACK!", f1, b1);
}

static std::string (*_I18n$get)(std::string const&);
static std::string I18n$get(std::string const& key) {
	if(key == "menu.copyright")
		return std::string{"©Mojang AB+§cDark Shuper"};

	return _I18n$get(key);
}

static std::string (*_Common$getGameVersionStringNet)(uintptr_t*);
static std::string Common$getGameVersionStringNet(uintptr_t* self) {

	return "1.17.2+§aMods";
}

%ctor {
	VTDirt = (uintptr_t**)(0x105e15c30 + _dyld_get_image_vmaddr_slide(0));

	_DirtBlock$getColor = (uint32_t(*)(uintptr_t*, uintptr_t const&)) VTDirt[126];
	VTDirt[126] = (uintptr_t*)&DirtBlock$getColor;

	MSHookFunction((void*)(0x100323b68 + _dyld_get_image_vmaddr_slide(0)), (void*)&GuiMessage$GuiMessage, (void**)&_GuiMessage$GuiMessage);
	MSHookFunction((void*)(0x102df4f60 + _dyld_get_image_vmaddr_slide(0)), (void*)&I18n$get, (void**)&_I18n$get);
	MSHookFunction((void*)(0x1026726ac + _dyld_get_image_vmaddr_slide(0)), (void*)&Common$getGameVersionStringNet, (void**)&_Common$getGameVersionStringNet);
}
class = {}
subclass = class --syntactic sugar; both class(super) and subclass(super) can be used to extend an existing class

local class_mt = {}
setmetatable(class, class_mt)

--create an instance of a class
local function newObject(class, ...)
	local object = {}
	setmetatable(object, class)
	if (object.init) then object:init(...) end
	return object
end

--create a new class
local function newClass(_, super)
	local class = {}
	local class_mt = {}
	setmetatable(class, class_mt)
	class_mt.__index = super
	class_mt.__call = newObject
	class.new = newObject
	class.super = super
	class.class = class --yo dawg
	class.base = class
	class.extend = subclass --syntactic sugar: "super:extend()" := "subclass(super)"
	class.__index = class
	return class
end

class_mt.__call = newClass
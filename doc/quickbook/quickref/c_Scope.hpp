
/*
 *  Copyright 2015 Matus Chochlik.
 */

//[reflexpr_Scope_def

template <typename T>
__concept bool Scope =
	__Object<T> &&
	__meta::__is_scope_v<T>;

//]
//[reflexpr_Scope_begin
__namespace_meta_begin
//]
//[reflexpr_Scope_inherited_traits

//]
//[reflexpr_Scope_traits

template <>
struct __is_scope<Scope>
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

//]
//[reflexpr_Scope_inherited_operations

template <>
struct __reflects_same<Scope, Scope>
{
	
	typedef bool value_type;
	static constexpr const bool value = ... /*<
	indicates if two metaobjects reflect the same base-level declaration.
	>*/;

	typedef __integral_constant<bool, value> type;

	operator bool (void) const noexcept;
	bool operator(void) const noexcept;
	
};

template <>
struct __get_source_location<Scope>
{
	
	typedef __SourceLocation value_type; /*<
	returns the source location info of the declaration of a scope reflected by a Scope.
	>*/
	
};

//]
//[reflexpr_Scope_operations

//]
//[reflexpr_Scope_end
__namespace_meta_end
//]

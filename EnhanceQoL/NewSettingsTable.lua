local addonName, addon = ...

addon.variables.NewVersionTableEQOL = {
	-- 13.17.0
	CameraZoom = not addon.variables.isForever or nil,
	maxCameraZoom = not addon.variables.isForever or nil,
	Bags_bankMaxColumns = true,
	merchantKnownIconsOnly = true,
	ResourceBarsSharedAssignments = true,
	healthPotionPriority = true,
	healthResetConditions = true,
	healthResetSeconds = true,
	healthResetClassOverride = true,
	healthResetClassConditions = true,
	healthResetClassSeconds = true,
	squareMinimapStatsSubzoneUseZoneColor = true,
	-- Unreleased development features
}

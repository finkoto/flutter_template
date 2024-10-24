class RefreshTokenConfig {
  const RefreshTokenConfig({
    required this.refreshUrl,
    this.refreshQueryParameters,
    this.refreshData,
  });

  final String refreshUrl;
  final Map<String, dynamic>? refreshQueryParameters;
  final Map<String, dynamic>? refreshData;
}

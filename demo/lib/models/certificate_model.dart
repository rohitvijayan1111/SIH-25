class Certificate {
  final String batchId;
  final String certId;
  final String certHash;
  final String issuerId;
  final String issuerName;
  final String issuedAt;
  final String fileCid;
  final String chainTx;

  Certificate({
    required this.batchId,
    required this.certId,
    required this.certHash,
    required this.issuerId,
    required this.issuerName,
    required this.issuedAt,
    required this.fileCid,
    required this.chainTx,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      batchId: json['batch_id'] ?? '',
      certId: json['cert_id'] ?? '',
      certHash: json['cert_hash'] ?? '',
      issuerId: json['issuer_id'] ?? '',
      issuerName: json['issuer_name'] ?? '',
      issuedAt: json['issued_at'] ?? '',
      fileCid: json['file_cid'] ?? '',
      chainTx: json['chain_tx'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "batch_id": batchId,
      "cert_id": certId,
      "cert_hash": certHash,
      "issuer_id": issuerId,
      "issuer_name": issuerName,
      "issued_at": issuedAt,
      "file_cid": fileCid,
      "chain_tx": chainTx,
    };
  }
}

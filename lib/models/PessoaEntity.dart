/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the PessoaEntity type in your schema. */
class PessoaEntity extends amplify_core.Model {
  static const classType = const _PessoaEntityModelType();
  final String id;
  final String? _nome;
  final String? _idade;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  PessoaEntityModelIdentifier get modelIdentifier {
      return PessoaEntityModelIdentifier(
        id: id
      );
  }
  
  String get nome {
    try {
      return _nome!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get idade {
    return _idade;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const PessoaEntity._internal({required this.id, required nome, idade, createdAt, updatedAt}): _nome = nome, _idade = idade, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory PessoaEntity({String? id, required String nome, String? idade}) {
    return PessoaEntity._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      nome: nome,
      idade: idade);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PessoaEntity &&
      id == other.id &&
      _nome == other._nome &&
      _idade == other._idade;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("PessoaEntity {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("nome=" + "$_nome" + ", ");
    buffer.write("idade=" + "$_idade" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  PessoaEntity copyWith({String? nome, String? idade}) {
    return PessoaEntity._internal(
      id: id,
      nome: nome ?? this.nome,
      idade: idade ?? this.idade);
  }
  
  PessoaEntity copyWithModelFieldValues({
    ModelFieldValue<String>? nome,
    ModelFieldValue<String?>? idade
  }) {
    return PessoaEntity._internal(
      id: id,
      nome: nome == null ? this.nome : nome.value,
      idade: idade == null ? this.idade : idade.value
    );
  }
  
  PessoaEntity.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _nome = json['nome'],
      _idade = json['idade'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'nome': _nome, 'idade': _idade, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'nome': _nome,
    'idade': _idade,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<PessoaEntityModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<PessoaEntityModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NOME = amplify_core.QueryField(fieldName: "nome");
  static final IDADE = amplify_core.QueryField(fieldName: "idade");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "PessoaEntity";
    modelSchemaDefinition.pluralName = "PessoaEntities";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PessoaEntity.NOME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PessoaEntity.IDADE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _PessoaEntityModelType extends amplify_core.ModelType<PessoaEntity> {
  const _PessoaEntityModelType();
  
  @override
  PessoaEntity fromJson(Map<String, dynamic> jsonData) {
    return PessoaEntity.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'PessoaEntity';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [PessoaEntity] in your schema.
 */
class PessoaEntityModelIdentifier implements amplify_core.ModelIdentifier<PessoaEntity> {
  final String id;

  /** Create an instance of PessoaEntityModelIdentifier using [id] the primary key. */
  const PessoaEntityModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'PessoaEntityModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is PessoaEntityModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
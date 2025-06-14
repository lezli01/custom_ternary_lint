import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _TernaryPlugin();

class _TernaryPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        NoTernaryOperatorRule(),
      ];
}

class NoTernaryOperatorRule extends DartLintRule {
  NoTernaryOperatorRule()
      : super(
          code: const LintCode(
            name: 'no_ternary_operator',
            problemMessage: 'Avoid using ternary operators (?:).',
            correctionMessage:
                'Use if/else instead, or ConditionBuilder or some other approach.',
          ),
        );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addConditionalExpression((ConditionalExpression node) {
      reporter.atNode(node, code);
    });
  }
}

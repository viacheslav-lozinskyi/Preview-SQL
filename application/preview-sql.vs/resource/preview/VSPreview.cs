using Microsoft.SqlServer.Management.SqlParser.Common;
using Microsoft.SqlServer.Management.SqlParser.Parser;
using Microsoft.SqlServer.Management.SqlParser.SqlCodeDom;
using System;

namespace resource.preview
{
    internal class VSPreview : extension.AnyPreview
    {
        protected override void _Execute(atom.Trace context, int level, string url, string file)
        {
            try
            {
                var a_Context = new ParseOptions("GO", true, DatabaseCompatibilityLevel.Version80);
                {
                    a_Context.TransactSqlVersion = TransactSqlVersion.Version105;
                }
                {
                    var a_Context1 = Parser.Parse("SELECT ShortName FROM Groups (nolock)", a_Context);
                    if (a_Context1 != null)
                    {
                        foreach (var a_Context2 in a_Context1.Script.Children)
                        {
                            __Execute(context, level, url, a_Context2);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                context.
                    SetUrl(file/*, __GetErrorValue(ex.Message, "Line", ","), __GetErrorValue(ex.Message, "column", ":")*/).
                    Send(NAME.SOURCE.PREVIEW, NAME.TYPE.EXCEPTION, level, ex.Message).
                    SendPreview(NAME.TYPE.EXCEPTION, url);
            }
        }

        private static void __Execute(atom.Trace context, int level, string url, SqlCodeObject data)
        {
            // TODO: Implement it
        }
    };
}

using Microsoft.SqlServer.Management.SqlParser.Common;
using Microsoft.SqlServer.Management.SqlParser.Parser;
using Microsoft.SqlServer.Management.SqlParser.SqlCodeDom;
using System;
using System.IO;

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
                    var a_Context1 = Parser.Parse(File.ReadAllText(file), a_Context);
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
                    SetUrl(file).
                    Send(NAME.SOURCE.PREVIEW, NAME.EVENT.EXCEPTION, level, ex.Message).
                    SendPreview(NAME.EVENT.EXCEPTION, url);
            }
        }

        private static void __Execute(atom.Trace context, int level, string url, SqlCodeObject data)
        {
            var a_IsFound = (data.GetType().Name != "SqlBatch") && (data.Sql != data.Parent.Sql);
            if (a_IsFound)
            {
                context.
                    SetUrl(url, data.StartLocation.LineNumber, data.StartLocation.ColumnNumber).
                    SetComment(__GetComment(data), "<SQL [[[data type]]]>").
                    Send(atom.Trace.NAME.SOURCE.PREVIEW, __GetType(data, level), level, __GetCleanText(data.Sql));
            }
            {
                foreach (var a_Context in data.Children)
                {
                    __Execute(context, level + (a_IsFound ? 1 : 0), url, a_Context);
                }
            }
        }

        private static string __GetType(SqlCodeObject data, int level)
        {
            if (level == 1)
            {
                return atom.Trace.NAME.EVENT.OBJECT;
            }
            if (data.GetType().Name.Contains("Identifier"))
            {
                return atom.Trace.NAME.EVENT.VARIABLE;
            }
            return atom.Trace.NAME.EVENT.PARAMETER;
        }

        private static string __GetComment(SqlCodeObject data)
        {
            var a_Result = "<" + data.GetType().Name + ">";
            {
                a_Result = a_Result.Replace("<Sql", "<");
            }
            return a_Result;
        }

        private static string __GetCleanText(string value)
        {
            var a_Result = value;
            var a_Size = GetProperty(NAME.PROPERTY.DEBUGGING_STRING_SIZE, true);
            if (a_Result != null)
            {
                {
                    a_Result = a_Result.Replace("\r\n", " ");
                    a_Result = a_Result.Replace("\r", " ");
                    a_Result = a_Result.Replace("\n", " ");
                    a_Result = a_Result.Replace("\t", " ");
                }
                while (a_Result.Contains("  "))
                {
                    a_Result = a_Result.Replace("  ", " ");
                }
                {
                    a_Result = a_Result.Replace("NOT", "<<<N>>>OT");
                    a_Result = a_Result.Replace("not", "<<<n>>>ot");
                    a_Result = a_Result.Replace("( ", " ");
                    a_Result = a_Result.Replace(" )", " ");
                    a_Result = a_Result.Replace(" ,", ", ");
                }
            }
            if (a_Result?.Length > a_Size)
            {
                a_Result = a_Result.Substring(0, a_Size) + "...";
            }
            return a_Result;
        }
    };
}

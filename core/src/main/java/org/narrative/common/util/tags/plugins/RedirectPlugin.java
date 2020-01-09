/*
 * Copyright 1999,2005 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.narrative.common.util.tags.plugins;

import org.apache.jasper.compiler.tagplugin.TagPlugin;
import org.apache.jasper.compiler.tagplugin.TagPluginContext;

public class RedirectPlugin implements TagPlugin {

    public void doTag(TagPluginContext ctxt) {

        //flag for the existence of the "context"
        boolean hasContext = ctxt.isAttributeSpecified("context");

        //names of the temp variables
        String urlName = ctxt.getTemporaryVariableName();
        String contextName = ctxt.getTemporaryVariableName();
        String baseUrlName = ctxt.getTemporaryVariableName();
        String resultName = ctxt.getTemporaryVariableName();
        String responseName = ctxt.getTemporaryVariableName();

        //get context
        ctxt.generateJavaSource("String " + contextName + " = null;");
        if (hasContext) {
            ctxt.generateJavaSource(contextName + " = ");
            ctxt.generateAttribute("context");
            ctxt.generateJavaSource(";");
        }

        //get the url
        ctxt.generateJavaSource("String " + urlName + " = ");
        ctxt.generateAttribute("url");
        ctxt.generateJavaSource(";");

        //get the raw url according to "url" and "context"
        ctxt.generateJavaSource("String " + baseUrlName + " = " + "org.apache.jasper.tagplugins.jstl.Util.resolveUrl(" + urlName + ", " + contextName + ", _jspx_page_context);");
        ctxt.generateJavaSource("_jspx_page_context.setAttribute" + "(\"url_without_param\", " + baseUrlName + ");");

        //add params
        ctxt.generateBody();

        ctxt.generateJavaSource("String " + resultName + " = " + "(String)_jspx_page_context.getAttribute(\"url_without_param\");");
        ctxt.generateJavaSource("_jspx_page_context.removeAttribute" + "(\"url_without_param\");");

        //get the response object
        ctxt.generateJavaSource("HttpServletResponse " + responseName + " = " + "((HttpServletResponse) _jspx_page_context.getResponse());");

        //if the url is relative, encode it
        ctxt.generateJavaSource("if(!org.apache.jasper.tagplugins.jstl.Util.isAbsoluteUrl(" + resultName + ")){");
        ctxt.generateJavaSource("    " + resultName + " = " + responseName + ".encodeRedirectURL(" + resultName + ");");
        ctxt.generateJavaSource("}");

        //do redirect
        ctxt.generateJavaSource("try{");
        ctxt.generateJavaSource("    " + responseName + ".sendRedirect(" + resultName + ");");
        ctxt.generateJavaSource("}catch(java.io.IOException ex){");
        ctxt.generateJavaSource("    throw new JspTagException(ex.toString(), ex);");
        ctxt.generateJavaSource("}");
    }

}

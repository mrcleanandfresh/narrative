<%--
  User: jonmark
  Date: 3/19/18
  Time: 2:37 PM
--%>
<%@ tag pageEncoding="UTF-8" body-content="empty" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ss" uri="http://www.narrative.org/tags/core" %>
<%@ taglib prefix="h" uri="http://www.narrative.org/tags/handy" %>
<%@ taglib prefix="comp" tagdir="/WEB-INF/tags/components" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/common/page" %>
<%@ taglib prefix="tool" tagdir="/WEB-INF/tags/common/tool" %>
<%@ taglib prefix="s_page" tagdir="/WEB-INF/tags/site/page" %>
<%@ taglib prefix="narrative" tagdir="/WEB-INF/tags/site/custom/narrative" %>
<%@ taglib prefix="n_email" tagdir="/WEB-INF/tags/site/custom/narrative/email" %>
<%@ taglib prefix="e" tagdir="/WEB-INF/tags/common/email/elements" %>

<ss:ref var="task" className="org.narrative.network.customizations.narrative.niches.niche.services.SendNicheApprovedEmail"/>

<ss:set var="niche" object="${task.niche}" className="org.narrative.network.customizations.narrative.niches.niche.Niche" />

<n_email:emailWrapper
        subject="${h:wordlet1Arg('jsp.site.custom.narrative.email.emailNicheApproved.subject', niche.nameForHtml)}"
        actionText="${h:wordlet1Arg('jsp.site.custom.narrative.email.emailNicheApproved.viewNiche', niche.nameForHtml)}"
        actionUrl="${niche.displayUrl}">
    <e:elt name="p">
        <%-- jw: note: due to email preview, we are only going to be checking for null state  --%>
        <ss:set var="wordletSuffix" object="${task.dueToIssue ne null ? '.dueToAppeal' : ''}" className="java.lang.String" />
        <ss:set var="nicheLink">
            <e:a href="${niche.displayUrl}">${niche.nameForHtml}</e:a>
        </ss:set>
        ${h:wordlet1Arg('jsp.site.custom.narrative.email.emailNicheApproved.intro'+=wordletSuffix, nicheLink)}
    </e:elt>
</n_email:emailWrapper>


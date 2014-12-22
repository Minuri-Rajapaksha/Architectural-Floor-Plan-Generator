//tabstop=4
//*****************************************************************************/
// Project: jpl
//
// File:    $Id: Test.java,v 1.2 1999/05/05 13:46:11 fadushin Exp $
// Date:    $Date: 1999/05/05 13:46:11 $
// Author:  Fred Dushin <fadushin@syr.edu>
//          
//
// Description:
//    
//
// -------------------------------------------------------------------------
// Copyright (c) 1998 Fred Dushin
//                    All rights reserved.
// 
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Library Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Library Public License for more details.
//*****************************************************************************/

import java.util.Hashtable;
import jpl.Atom;
import jpl.Variable;
import jpl.Term;
import jpl.Query;
import jpl.JPL;

public class Test
{
	public static void
	main( String argv[] )
	{
		JPL.init();

		Term consult_arg[] = { 
			new Atom( "test.pl" ) 
		};
		Query consult_query = 
			new Query( 
				"consult", 
				consult_arg );

		boolean consulted = consult_query.query();
		
		if ( !consulted ){
			System.err.println( "Consult failed" );
			System.exit( 1 );
		}
		
		test_1();
		test_2();
		test_3();
		test_4();
	}
	
	
	static void
	test_1()
	{
		Term args[] = { 
			new Atom( "joe" ),
			new Atom( "ralf" )
		};
		Query query = 
			new Query( 
				"child_of", 
				args );

		System.out.println( "child_of(joe, ralf) = " + query.query() );
	}
	
	
	static void
	test_2()
	{
		Term args[] = { 
			new Atom( "steve" ),
			new Atom( "ralf" )
		};
		Query query = 
			new Query( 
				"descendent_of", 
				args );

		System.out.println( "descendent_of(steve, ralf) = " + query.query() );
	}
	
	
	static void
	test_3()
	{
		Variable X = new Variable();
		Term args[] = { 
			X,
			new Atom( "ralf" )
		};
		Query query = 
			new Query( 
				"descendent_of", 
				args );

		System.out.println( "querying descendent_of( X, ralf )" );
		java.util.Hashtable solution =
			query.oneSolution();
		System.out.println( "X = " + solution.get( X ) );
	}
	
	
	static void
	test_4()
	{
		Variable X = new Variable();
		Term args[] = { 
			X,
			new Atom( "ralf" )
		};
		Query query = 
			new Query( 
				"descendent_of", 
				args );

		System.out.println( "querying descendent_of( X, ralf )" );
		
		while ( query.hasMoreSolutions() ){
			java.util.Hashtable solution =
				query.nextSolution();
			System.out.println( "X = " + solution.get( X ) );
		}

	}
}
